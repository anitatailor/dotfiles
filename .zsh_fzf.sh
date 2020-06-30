#!/bin/bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable alt-c in iterm
bindkey "ç" fzf-cd-widget

# export FZF_DEFAULT_OPTS="--no-mouse --height=70% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -100' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
export FZF_DEFAULT_OPTS="--no-mouse --height=50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -100' --preview-window='right:hidden:wrap'"

export FD_OPTIONS='--follow --exclude .git'
# use ls-files in git repos, else fd
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# for fzf '**' shell completions.
# - The first argument to the function ($1) is the base path to start traversal
_fzf_compgen_path() {
  command fd --hidden --follow --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  command fd --type d --hidden --follow --exclude .git . "$1"
}


# Use fd and fzf to get the args to a command.
# f() {
#     sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
#     test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
# }

# # Like f, but not recursive
# fm() f "$@" --max-depth 1



# Open the selected file with default editor
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fcd - cd to selected directory
# Similar to default ALT+C fzf key binding
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}

# cd to selected parent dir
fpd() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# fkill - kill process
# Similar to "kill -9 **" fzf default completion
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Wrapper over wd. List bookmarks in fzf and pipe selected alias to "wd"
# mfaerevaag/wd: Jump to custom directories in zsh - https://github.com/mfaerevaag/wd
# Inspired by: Fuzzy bookmarks for your shell [Dmitry Frank] - https://dmitryfrank.com/articles/shell_shortcuts
fwd() {
  local wdpoint
  wdpoint=$(wd list | sed 1d | fzf | awk '{ print $1 }')

  if [ "$wdpoint" != "" ]
  then
    wd "$wdpoint"
  fi
}

# Integration with z
# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && fasd_cd -d "$*" && return
  cd $(fasd -dl 2>&1 | fzf --height 40% --reverse --inline-info +s --tac --query "${*##-* }")
}
