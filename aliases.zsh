# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && say 'DNS cache flushed'"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
weather() { curl -4 wttr.in/${1:-dallas} }
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias composer="php -d memory_limit=-1 /usr/local/bin/composer"
alias zbundle="antibody bundle < $DOTFILES/zsh_plugins.txt > $DOTFILES/zsh_plugins.sh"
alias serve=valet share
alias vstart="valet start && brew services start mysql"
alias vstop="valet stop && brew services stop mysql"
alias chrome="open -n -a /Applications/Google\ Chrome.app --args --user-data-dir='/tmp/chrome_dev_session' --disable-web-security"

alias php='nocorrect php'
alias npm='nocorrect npm'
alias yarn='nocorrect yarn'

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"
alias cake="cd $HOME/Sites/eat-cake"
alias lara="sites && cd laravel/"
alias braodway="cd $HOME/broadway"

# Laravel
alias a="nocorrect php artisan"
alias va="nocorrect valet php artisan"
alias ams="php artisan migrate:fresh --seed"

# PHP
alias php73="/usr/local/Cellar/php@7.3/7.3.13/bin/php"
alias php72="/usr/local/Cellar/php@7.2/7.2.26/bin/php"
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Vagrant
alias v="vagrant global-status"
alias vup="vagrant up"
alias vhalt="vagrant halt"
alias vssh="vagrant ssh"
alias vreload="vagrant reload"
alias vrebuild="vagrant destroy --force && vagrant up"

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
alias cmstart="docker-compose -f ~/Sites/cmdev/web/docker-compose.yml up -d && docker-compose -f ~/Sites/cmdev/partner-dashboard/docker-compose.yml up -d && docker-compose -f ~/Sites/cmdev/elastic-legacy/docker-compose.yml up -d && docker-compose -f ~/Sites/cmdev/orders/docker-compose.yml up -d"
alias cmstop="docker-compose -f ~/Sites/cmdev/web/docker-compose.yml down && docker-compose -f ~/Sites/cmdev/partner-dashboard/docker-compose.yml down && docker-compose -f ~/Sites/cmdev/elastic-legacy/docker-compose.yml down && docker-compose -f ~/Sites/cmdev/orders/docker-compose.yml down"
alias cmrestart="cmstop && cmstart"
alias cmrphp="docker-compose -f ~/Sites/cmdev/web/docker-compose.yml down && cmstart"

alias m7start="docker-compose -f ~/Sites/m7/docker-compose.yml up -d"
alias m7stop="docker-compose -f  ~/Sites/m7/docker-compose.yml down"
alias m7restart="m7stop && m7start"

alias cmdisablexdebug="docker exec -it cm-web-php /bin/bash -c 'mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled && ls -l /usr/local/etc/php/conf.d' && sleep 1 && cmrphp"
alias cmenablexdebug="docker exec -it cm-web-php /bin/bash -c 'mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini' && sleep 1 && cmrphp"
alias cmphpinilist="docker exec -it cm-web-php /bin/bash -c 'ls -l /usr/local/etc/php/conf.d'"

alias cmpd="docker exec -it cm-partner-dashboard-php"

alias restartvalet-"rm ~/.config/valet/valet.sock && valet restart"
alias coverage="export XDEBUG_MODE=coverage && vendor/bin/phpunit --coverage-html reports/"