#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export PS1="\[\033[33;1m\]\w\[\033[m\] \$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
	. /usr/local/share/bash-completion/bash_completion
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

eval "$(fasd --init auto)"

#### git prompt ####
GIT_PROMPT_ONLY_IN_REPO=1 # Use the default prompt when not in a git repo.
GIT_PROMPT_FETCH_REMOTE_STATUS=1 # Avoid fetching remote status
GIT_PROMPT_SHOW_UPSTREAM=1 # Don't display upstream tracking branch
GIT_SHOW_UNTRACKED_FILES=all # Don't count untracked files (no, normal, all)
GIT_PROMPT_ONLY_IN_REPO=1

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
	__GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
	source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# Add an "alert" alias for long running commands.  Use like so:

#   sleep 10; alert

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#aws cli
export PATH="$PATH":/Users/saswatdutta/Library/Python/3.7/bin/

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

if [ -e /Users/saswatdutta/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/saswatdutta/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/saswatdutta/.sdkman"
[[ -s "/Users/saswatdutta/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/saswatdutta/.sdkman/bin/sdkman-init.sh"
