# Shortcuts
alias vim=nvim
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && say 'DNS cache flushed'"
weather() { curl -4 wttr.in/${1:-eindhoven} }
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
# alias composer="php -d memory_limit=-1 /path/to/composer" # add to machine-aliases.zsh
alias zbundle="antibody bundle < $DOTFILES/zsh_plugins.txt > $DOTFILES/zsh_plugins.sh"
alias chrome="open -n -a /Applications/Google\ Chrome.app --args --user-data-dir='/tmp/chrome_dev_session' --disable-web-security"

alias dlbook="audiobook-dl --username=st202311@daronspence.com --password=$(op read 'op://Shared/Storytel 2023-11/password')"

# alias php='nocorrect php'
alias npm='nocorrect npm'
alias yarn='nocorrect yarn'

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"
alias cake="cd $HOME/Sites/eat-cake"

# Laravel
alias a="nocorrect php artisan"
alias ams="php artisan migrate:fresh --seed"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Docker
alias docker-composer="docker-compose"
#alias dstop="docker stop $(docker ps -a -q)"
#alias dpurgecontainers="dstop && docker rm $(docker ps -a -q)"
#alias dpurgeimages="docker rmi $(docker images -q)"
#dbuild() { docker build -t=$1 .; }
#dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

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

# Work stuff
alias cmdisablexdebug="docker exec -it cm-web-php /bin/bash -c 'mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled && ls -l /usr/local/etc/php/conf.d' && sleep 1 && cmrphp"
alias cmenablexdebug="docker exec -it cm-web-php /bin/bash -c 'mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini' && sleep 1 && cmrphp"
alias cmphpinilist="docker exec -it cm-web-php /bin/bash -c 'ls -l /usr/local/etc/php/conf.d'"

alias cmpd="docker exec -it cm-partner-dashboard-php"

alias coverage="export XDEBUG_MODE=coverage && vendor/bin/phpunit --coverage-html reports/"

function tab () {
    FOUND=$(which ttab)
    args="$@"
    if [[ ${FOUND} != *"not found"* ]];then
        ttab $args
        return
    fi

    echo "New tab package not found. Installing from npm."
    npm install ttab -g
    echo "Package installed.\nPlease restart your terminal and re-run the command."
}