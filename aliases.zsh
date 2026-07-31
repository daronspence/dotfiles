source $DOTFILES/path.zsh

# Shortcuts
alias vim=nvim
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && say 'DNS cache flushed'"
weather() { curl -4 wttr.in/${1:-eindhoven} }
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias zbundle="antibody bundle < $DOTFILES/zsh_plugins.txt > $DOTFILES/zsh_plugins.sh"
alias chrome="open -n -a /Applications/Google\ Chrome.app --args --user-data-dir='/tmp/chrome_dev_session' --disable-web-security"

# alias php='nocorrect php'
alias npm='nocorrect npm'
alias yarn='nocorrect yarn'

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"
alias cake="cd $HOME/Sites/eat-cake"

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Laravel
alias a="nocorrect php artisan"
alias ams="php artisan migrate:fresh --seed"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"

# Git
alias commit="git add . && git commit -m"
alias gcommit="git add . && git commit"
alias amend="git add . && git commit --amend --no-edit"
alias wip="commit wip"
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias resolve="git add . && git commit --no-edit"
alias gl="git log --oneline --decorate --color"
alias nuke="git clean -df && git reset --hard"
alias unstage="git restore --staged ."
alias pushup="git push -u origin HEAD"
alias claer="clear"
alias coverage="export XDEBUG_MODE=coverage && vendor/bin/phpunit --coverage-html reports/"
alias lg="lazygit"

# If __zoxide_z exists, alias as cd as z
if command -v zoxide >/dev/null 2>&1; then
    alias cd='z'
fi

tab() {
  if (( $# == 0 )); then
    print -u2 'usage: tab <command> [arguments...]'
    return 2
  fi

  local command_text
  printf -v command_text '%q ' "$@"

  osascript - "$PWD" "$command_text" <<'APPLESCRIPT'
on run argv
  set workingDirectory to item 1 of argv
  set commandText to item 2 of argv

  tell application "Ghostty"
    activate

    set cfg to new surface configuration
    set initial working directory of cfg to workingDirectory
    set initial input of cfg to commandText & "\n"

    if (count of windows) = 0 then
      new window with configuration cfg
    else
      new tab in front window with configuration cfg
    end if
  end tell
end run
APPLESCRIPT
}

function dlbook () {
    audiobook-dl --username=st202311@daronspence.com --password=$(op read 'op://Shared/Storytel 2023-11/password') $args
}

function what() {
    lsof -Pni:${1}
}

alias waht=what
alias killnginx="sudo pkill -f \"nginx-arm\""