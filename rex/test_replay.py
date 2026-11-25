"""Run with python3; --shell uses ~/.zshrc, --dev also exercises the dev TUI."""
import json
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys
import tempfile
import time


def main():
    rex = shutil.which("rex")
    hook = Path(__file__).with_name("replay.zsh")
    assert rex, "rex must be installed"
    use_dev = "--dev" in sys.argv
    use_shell = use_dev or "--shell" in sys.argv
    with tempfile.TemporaryDirectory(prefix="rex-replay-", dir="/tmp") as root:
        root = Path(root)
        endpoint = f"unix://{root}/server.sock"
        state = root / "server-state"
        config = root / "init.lua"
        config.write_text("")
        zdot = root / "zsh"
        zdot.mkdir()
        trace = root / "trace"
        work = root / "work with spaces"
        work.mkdir()
        bindir = root / "bin"
        bindir.mkdir()
        # The hook must query the test server, never the user's live server.
        wrapper = bindir / "rex"
        wrapper.write_text(f"#!/bin/sh\nexec {shlex.quote(rex)} -S {shlex.quote(endpoint)} \"$@\"\n")
        wrapper.chmod(0o700)
        (zdot / ".zshrc").write_text(
            (f"source {shlex.quote(str(Path.home() / '.zshrc'))}\n"
             f"export PATH={shlex.quote(str(bindir))}:$PATH\n" if use_shell else
             f"source {shlex.quote(str(hook))}\n") + "print -r -- REX_SHELL_READY\nPS1='REX_READY> '\n"
        )

        def cli(*args, decode=False):
            result = subprocess.run(
                [rex, "-S", endpoint, "--autostart=false", *args],
                capture_output=True, text=True, timeout=8, check=True,
            ).stdout
            return json.loads(result) if decode else result

        def start():
            cli(
                "server", "start", "--state-dir", str(state), "--config", str(config),
                "--env", f"ZDOTDIR={zdot}",
                "--env", f"XDG_STATE_HOME={root / 'shell-state'}",
                "--env", f"PATH={bindir}:{os.environ['PATH']}",
            )

        def until(predicate):
            deadline = time.monotonic() + (15 if use_shell else 6)
            while time.monotonic() < deadline:
                if predicate():
                    return
                time.sleep(0.05)
            raise AssertionError("Timed out waiting for restored terminal")

        def entries():
            return trace.read_text().splitlines() if trace.exists() else []

        def send(block, text):
            cli("send", "-b", block, text)
            cli("send-key", "-b", block, "enter")

        def capture(block):
            return cli("capture", "-b", block, "--trim")

        def new_shell(session):
            result = cli(
                "run", "-s", session, "--shell=none", "--json", "--", "/usr/bin/env",
                f"ZDOTDIR={zdot}", f"XDG_STATE_HOME={root / 'shell-state'}",
                f"PATH={bindir}:{os.environ['PATH']}", "_REX_REPLAY_SHELL_BLOCK=",
                "/bin/zsh", "-l" if use_shell else "-d", "-i", decode=True,
            )
            block = result["block_ids"][0]
            until(lambda: "REX_SHELL_READY" in capture(block))
            return block

        try:
            start()
            session = cli("api", "call", "session.create", '{"label":"replay-test"}', decode=True)["session_id"]
            busy = new_shell(session)
            idle = new_shell(session)
            if use_dev:
                saved = root / "shell-state" / "rex-replay" / busy.replace(":", "_")

                def running_dev():
                    capture(busy)  # Attach and start a restored terminal.
                    process = cli("block", "call", "-b", busy, "process", decode=True)
                    return (process.get("foreground") or {}).get("name") == "php"

                send(busy, "dev")
                until(running_dev)
                record = json.loads(saved.read_text())
                assert record["command"] == "dev", record
                for _ in range(2):
                    old_instance = record["instance"]
                    cli("server", "stop")
                    until(lambda: not (root / "server.sock").exists())
                    start()
                    until(running_dev)
                    record = json.loads(saved.read_text())
                    current = cli("whoami", "--json", decode=True)["instance_id"]
                    assert record["instance"] == current != old_instance, record
                    assert record["command"] == "dev", record
                    assert "Rex: replaying interrupted command." not in capture(idle)
                print(capture(busy))
                print("PASS: real dev function and full .zshrc restored a running PHP TUI after two isolated server stop/starts; idle pane stayed idle.")
                return
            send(idle, f"print -r -- completed >> {shlex.quote(str(trace))}")
            until(lambda: entries() == ["completed"])
            pending = root / "shell-state" / "rex-replay" / idle.replace(":", "_")
            until(lambda: not pending.exists())
            send(busy, f"cd -- {shlex.quote(str(work))}")
            until(lambda: str(work) in capture(busy))
            # A compound command with quotes and a newline must survive unchanged.
            command = f"print -r -- \"$PWD|a 'quoted' value\" >> {shlex.quote(str(trace))}\nsleep 60"
            # Group it so zsh records one multiline command, not two commands.
            send(busy, "{ " + command + "; }")
            until(lambda: len(entries()) == 2)
            saved = root / "shell-state" / "rex-replay" / busy.replace(":", "_")
            assert saved.stat().st_mode & 0o777 == 0o600
            for expected in (3, 4):
                cli("server", "stop")
                until(lambda: not (root / "server.sock").exists())
                start()
                # Restored terminals start lazily when a client reads them.
                until(lambda: bool(capture(busy)) and len(entries()) == expected)
                assert entries() == ["completed"] + [f"{work}|a 'quoted' value"] * (expected - 1), entries()
                assert "Rex: replaying interrupted command." in capture(busy)
                assert "Rex: replaying interrupted command." not in capture(idle)
            cli("send-key", "-b", busy, "ctrl+c")
            until(lambda: not saved.exists())
            print("PASS: real isolated Rex restarts replay interrupted commands twice, preserve cwd/quoting, leave completed commands alone, and clear on Ctrl-C (0600 state).")
        except Exception:
            print("Trace:", entries())
            for name in ("busy", "idle"):
                block = locals().get(name)
                if block:
                    try:
                        print(name, capture(block))
                        print(cli("block", "call", "-b", block, "process"))
                    except subprocess.CalledProcessError as error:
                        print(error.stderr)
            raise
        finally:
            subprocess.run(
                [rex, "-S", endpoint, "--autostart=false", "server", "stop"],
                capture_output=True, timeout=8,
            )


if __name__ == "__main__":
    main()
