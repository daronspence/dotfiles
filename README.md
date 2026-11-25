# Daron's Dotfiles

## TODO
- Investigate https://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html

This repository serves as my way to help me setup and maintain my Mac. It takes the effort out of installing everything manually. Everything needed to install my preferred setup of macOS is detailed in this readme. Feel free to explore, learn and copy parts for your own dotfiles. Enjoy! :smile:

📖 Read the blog post: https://driesvints.com/blog/getting-started-with-dotfiles
📺 Watch the screencast on Laracasts: https://laracasts.com/series/guest-spotlight/episodes/1

## A Fresh macOS Setup

These instructions are for when you've already set up your dotfiles. If you want to get started with your own dotfiles you can [find instructions below](#your-own-dotfiles).

### Before you re-install

First, go through the checklist below to make sure you didn't forget anything before you wipe your hard drive.

- Did you commit and push any changes/branches to your git repositories?
- Did you remember to save all important documents from non-iCloud directories?
- Did you save all of your work from apps which aren't synced through iCloud?
- Did you remember to export important data from your local database?

### Setting up your Mac

If you did all of the above you may now follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. Copy your public and private SSH keys to `~/.ssh` and make sure they're set to `600`
5. Clone this repo to `~/.dotfiles`
6. Run `install.sh` to start the installation.
7. Restart your computer to finalize the process

Your Mac is now ready to use!

## Sharing Between Macs

The shared shell configuration supports Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`), uses `$HOME` for user paths, and loads `path.zsh` before prompt setup. Both Macs use fnm; the old NVM initialization is no longer needed.

Keep credentials and host-specific aliases in the ignored `machine-aliases.zsh`; do not copy that file between machines. Leave local backups and installed plugins on their original machine.

### Rex Command Replay

`.zshrc` sources `rex/replay.zsh` directly from this checkout; no separate `~/.config/rex` installation is needed. Open a new Rex pane to activate it.

After a Rex server restart, an interrupted command restarts **from the beginning**, in its original directory, with its original shell text. This is not process resume: commands with side effects may run twice. Completed commands and non-Rex shells are unaffected.

Pending commands (including their arguments) are stored privately under `${XDG_STATE_HOME:-$HOME/.local/state}/rex-replay` with mode `0600`, and cleared when the prompt returns or replay is interrupted.

Run `python3 ~/.dotfiles/rex/test_replay.py --shell` to test the actual shell configuration, quoting, working directory, two isolated server restarts, idle panes, and Ctrl-C cleanup. The test starts its own Rex server and does not restart live sessions.

## Your Own Dotfiles

If you want to start with your own dotfiles from this setup, it's pretty easy to do so. First of all you'll need to fork this repo. After that you can tweak it the way you want.

Go through the [`.macos`](./.macos) file and adjust the settings to your liking. You can find much more settings at [the original script by Mathias Bynens](https://github.com/mathiasbynens/dotfiles/blob/master/.macos) and [Kevin Suttle's macOS Defaults project](https://github.com/kevinSuttle/MacOS-Defaults).

Check out the [`Brewfile`](./Brewfile) file and adjust the apps you want to install for your machine.

Check out the [`aliases.zsh`](./aliases.zsh) file and add your own aliases. If you need to tweak your `$PATH` check out the [`path.zsh`](./path.zsh) file. These files get loaded in because the `$ZSH_CUSTOM` setting points to the `.dotfiles` directory. You can adjust the [`.zshrc`](./.zshrc) file to your liking to tweak your Oh My Zsh setup. More info about how to customize Oh My Zsh can be found [here](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization).

Enjoy your own Dotfiles!

## Thanks To...

This project was forked from Dries Vints' [dotfiles](https://github.com/driesvints/dotfiles).

In general, I'd like to thank every single one who open-sources their dotfiles for their effort to contribute something to the open-source community. Your work means the world! :earth_africa: :heart:
