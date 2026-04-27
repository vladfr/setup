# name in folder (github)
# ± if in github repo, or ≥ if otherwise Time in 24-hour format is on right.
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}
function prompt_char {
    echo -n "%{$bg[white]%}%{$fg[red]%}"
    git branch >/dev/null 2>/dev/null && echo "±%{$reset_color%}" && return
    echo "≥%{$reset_color%}"
}
function _k_prompt_info_async {
    cluster=$(kubectl config current-context)
    ns=$(kubens -c)
    if [ ! -z "$cluster" ]; then
        if [[ $string == *"prod"* ]]; then
            echo -en "⚡";
        fi
        echo "[$cluster::$ns]"
    fi
}

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
function _venv_prompt_info_async {
    VENV=$(pyenv version | cut -d ' ' -f 1)
    if [ ! -z "$VENV" ] && [ "$VENV" != "system" ]; then
        echo -n "%{$bg[white]%}%{$fg[black]%}"
        echo "#pyenv##$VENV#%{$reset_color%}"
    fi
}

function _defer_async_register() {
    _omz_register_handler _venv_prompt_info_async
    _omz_register_handler _k_prompt_info_async
}
precmd_functions=(_defer_async_register $precmd_functions)

function k_prompt_info {
    echo -n $_OMZ_ASYNC_OUTPUT[_k_prompt_info_async]
}

function venv_prompt_info {
    echo -n $_OMZ_ASYNC_OUTPUT[_venv_prompt_info_async]
}

RIXIUS_PRE="%{$bg[white]%}%{$fg[red]%}"

PROMPT='
%{$RIXIUS_PRE%}%n%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info) $(k_prompt_info) $(venv_prompt_info)
$(prompt_char) '
RPROMPT='%{$RIXIUS_PRE%}%T%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RIXIUS_PRE%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$RIXIUS_PRE%}√%{$reset_color%}"