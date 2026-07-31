# Profiling Start
# zmodload zsh/zprof

HISTFILE=~/.local/share/zsh/history
SAVEHIST=100000 # Max entries saved to file.
HISTSIZE=100000 # Max entires for in-memory history.

setopt hist_ignore_dups  # Collapse two consecutive idential commands.
setopt hist_find_no_dups  # Ignore duplicates when searching history.
setopt share_history  # Share across concurrent sessions (append immediately, read from files, add timestamps).
setopt hist_ignore_space  # Lines that begin with space are not recorded.
setopt hist_verify  # Don't auto-execute selected history entry.
setopt hist_ignore_all_dups  # If a history entry would be duplicate, delete older copies.

setopt COMBINING_CHARS # Combine multi-codepoint characters into one.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit
compinit

# 1password
eval "$(op completion zsh)"; compdef _op op

# zoxide
export _ZO_ECHO=1
eval "$(zoxide init zsh)"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/daron/.zsh/completions:"* ]]; then export FPATH="/Users/daron/.zsh/completions:$FPATH"; fi
# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles
export HOMEBREW_BUNDLE_FILE=$DOTFILES/Brewfile

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Minimal - Theme Settings
export MNML_INSERT_CHAR="$"
export MNML_PROMPT=(mnml_git mnml_keymap)
export MNML_RPROMPT=('mnml_cwd 20')

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="passion"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES

export XDG_CONFIG_HOME="$HOME/.config"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vscode git-trim)

# source $ZSH/oh-my-zsh.sh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    # Terminal THEME
    # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/montys.omp.json)"
    eval "$(oh-my-posh init zsh --config $DOTFILES/theme.omp.json)"
    source $DOTFILES/aliases.zsh
    [ -s "$DOTFILES/machine-aliases.zsh" ] && \. $DOTFILES/machine-aliases.zsh
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export ERL_AFLAGS="-kernel shell_history enabled"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

autoload -U add-zsh-hook

# Must have `fnm` installed
eval "$(fnm env --use-on-cd --shell zsh)"

# Herd injected PHP binary.
export PATH="$HOME/Library/Application Support/Herd/bin/":$PATH

# Created by `pipx` on 2024-05-14 10:59:16
export PATH="$PATH:$HOME/.local/bin"
# . "$HOME/.deno/env"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/daronspence/Library/Application Support/Herd/config/php/83/"

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/daronspence/Library/Application Support/Herd/config/php/84/"

# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/daronspence/Library/Application Support/Herd/config/php/82/"

# Vite+ bin (https://viteplus.dev)
[ -s "$HOME/.vite-plus/env" ] && \. "$HOME/.vite-plus/env"

# Profiling End
# zprof

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
