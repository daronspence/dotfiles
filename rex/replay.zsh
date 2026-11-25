# Exact command capture for replay.lua. Existing panes: source this file once.
# Non-Rex and nested shells are unaffected. Arguments are saved privately on disk.
[[ -o interactive && -n ${REX_BLOCK:-} ]] || return 0
[[ ${_REX_REPLAY_SHELL_BLOCK:-} != "$REX_BLOCK" ]] || return 0
export _REX_REPLAY_SHELL_BLOCK=$REX_BLOCK
typeset -g _rex_replay_script="${${(%):-%x}:A:h}/replay.lua"
typeset -gi _rex_replay_first_prompt=1

_rex_replay_preexec() {
    REX_REPLAY_COMMAND="$1" command rex --autostart=false do "$_rex_replay_script" mode=save ||
        print -u2 'Rex: could not save command for replay.'
    return 0
}

_rex_replay_precmd() {
    if (( _rex_replay_first_prompt )); then
        _rex_replay_first_prompt=0
        local replay
        replay=$(command rex --autostart=false do "$_rex_replay_script" mode=replay) || return 0
        setopt localoptions localtraps
        trap 'command rex --autostart=false do "$_rex_replay_script" mode=clear; return 130' INT
        eval "$replay"
    fi
    command rex --autostart=false do "$_rex_replay_script" mode=clear
    return 0
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _rex_replay_preexec
add-zsh-hook precmd _rex_replay_precmd
