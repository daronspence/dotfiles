-- Called by replay.zsh: save before execution, replay once, clear at the prompt.
-- Replay starts from the beginning, in the original cwd; it cannot restore memory.
-- Exact shell text comes from zsh because Rex process events omit arguments.
local block = assert(os.getenv("REX_BLOCK"), "Not in a Rex terminal")
assert(block:match("^block:[%x%-]+$"), "Invalid Rex block ID")
local root = (os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")) .. "/rex-replay"
local path = root .. "/" .. block:gsub(":", "_")
local mode = rex.args.mode

if mode == "clear" then
    os.remove(path)
    return
end

local server = assert(rex.call("server.status"))
local instance = assert(server.instance_id, "Server does not report its instance ID")
local function save(record)
    local dir = assert(rex.exec({ "mkdir", "-p", "-m", "700", root }))
    assert(dir.ok, dir.stderr)
    -- mktemp creates the file with mode 0600 before any command arguments are written.
    local temp = assert(rex.exec({ "mktemp", path .. ".XXXXXX" }))
    assert(temp.ok, temp.stderr)
    local name = temp.stdout:gsub("\n$", "")
    local file = assert(io.open(name, "w"))
    local written, err = file:write(rex.json.encode(record))
    local closed, close_err = file:close()
    if not written or not closed then
        os.remove(name)
        error(err or close_err)
    end
    local renamed, rename_err = os.rename(name, path)
    if not renamed then os.remove(name); error(rename_err) end
end

if mode == "save" then
    save({ instance = instance, cwd = assert(os.getenv("PWD")),
        command = assert(os.getenv("REX_REPLAY_COMMAND")) })
elseif mode == "replay" then
    local file = io.open(path, "r")
    if not file then return end
    local contents = file:read("*a")
    file:close()
    local record = rex.json.decode(contents)
    assert(type(record) == "table" and type(record.instance) == "string"
        and type(record.cwd) == "string" and type(record.command) == "string",
        "Invalid saved command")
    if record.instance == instance or record.command == "" then return end
    record.instance = instance
    save(record) -- Rearm before replay, including repeated server restarts.
    local function quote(text)
        return "'" .. text:gsub("'", "'\\''") .. "'"
    end
    -- Evaluated inside the first precmd hook, after aliases and shell setup load.
    print("builtin cd -- " .. quote(record.cwd) .. " || return 0")
    print("print -u2 'Rex: replaying interrupted command.'")
    print("eval " .. quote(record.command))
else
    error("Expected mode=save, mode=replay, or mode=clear")
end
