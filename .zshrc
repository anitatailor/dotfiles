#set variables for oh-my-zsh based plugins
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

# for oh-my-zsh
DISABLE_AUTO_UPDATE=true

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Enable autocompletions
autoload -Uz compaudit compinit 
#promptinit

typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE


# zsh Options
setopt cdablevars				 # jump to path vars from anywhere
setopt auto_cd 					 # cd by typing directory name if it's not a command
setopt auto_list                 # automatically list choices on ambiguous completion
setopt auto_menu                 # automatically use menu completion
setopt always_to_end             # move cursor to end if word had one match
setopt hist_reduce_blanks        # remove superfluous blanks from history items
setopt correct                   # correct comands
setopt correct_all               # autocorrect commands args
setopt interactive_comments      # allow comments in interactive shells
setopt append_history            # sessions will append their history list to the history file, rather than replace it
setopt bang_hist                 # Treat the '!' character specially during expansion.
setopt extended_history          # Write the history file in the ':start:elapsed;command' format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire a duplicate event first when trimming history.
setopt hist_ignore_dups          # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups      # Delete an old recorded event if a new event is a duplicate.
setopt hist_find_no_dups         # Do not display a previously found event.
setopt hist_ignore_space         # Do not record an event starting with a space.
setopt hist_save_no_dups         # Do not write a duplicate event to the history file.
setopt hist_verify               # Do not execute immediately upon history expansion.
setopt hist_beep                 # Beep when accessing non-existent history.
setopt complete_in_word          # Complete from both ends of a word.
setopt path_dirs                 # Perform path search even on command names with slashes.
setopt globdots					 # ignore dot while matching hidden files
setopt noclobber				 # prevent clobbering files use '>!' to clobber file
#setopt cshjunkiequotes           # illegal to leave off closing quotes
unsetopt case_glob               # Case-insensitive matching



typeset -U path cdpath fpath

# first try local dir completions, then from cd path
_cd_try_without_cdpath () {
  CDPATH= _cd "$@" || _cd "$@"
}
compdef _cd_try_without_cdpath cd pushd

### vyom specific cd paths
cdpath=( ./ $HOME/code/vyom/ /var/log/tomcat8/log/ )

# Improve autocompletion style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:descriptions' format %d
zstyle ':completion:*:descriptions' format %B%d%b
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'
zstyle ':completion:*:complete:(cd|pushd):*' group-name ''
zstyle ':completion:*:complete:(cd|pushd):*' format ' '


# Partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'


# Load antibody plugin manager
source <(antibody init)

# Plugins
antibody bundle < ~/.zsh_plugins.txt

#prompts
#source ~/.space_ship_prompt_config
source ~/.purepower

# Keybindings
#ref https://stackoverflow.com/questions/6205157/iterm-2-how-to-set-keyboard-shortcuts-to-jump-to-beginning-end-of-line
bindkey -e      # keep in emacs mode for Ctrl+<key> actions

# moves

bindkey "^[U"     backward-kill-line
bindkey "^X^_"    redo

bindkey '^[[A'    history-substring-search-up
bindkey '^[[B'    history-substring-search-down

# dirhist fn+arrow
bindkey '^[[H'  dirhistory_zle_dirhistory_back
bindkey '^[[F'  dirhistory_zle_dirhistory_future
bindkey '^[[5~' dirhistory_zle_dirhistory_up
bindkey '^[[6~' dirhistory_zle_dirhistory_down

# dircycle - fn+shift+arrow
bindkey '^[[1;2H' insert-cycledleft
bindkey '^[[1;2F' insert-cycledright


#############
# Termcolor
export TERM=xterm-256color

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

########### alias

# epoch in sec to date-time
alias from-unixtime='date -r ' 

# Colorful ls
alias ls='gls --color=auto -v -F -h'
# set LS_COLORS Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
eval $(gdircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | gdircolors -)

source ~/.bash_aliases
source /Users/saswatdutta/git-extras/etc/git-extras-completion.zsh



# set options for less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'


# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Set the Less input preprocessor.
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN='|lesspipe.sh %s'
fi

## faster completions for git files
__git_files () { 
    _wanted files expl 'local files' _files
}


#aws cli
export PATH="$PATH":/Users/saswatdutta/Library/Python/3.7/bin/
source /Users/saswatdutta/Library/Python/3.7/bin/aws_zsh_completer.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/saswatdutta/.sdkman"
[[ -s "/Users/saswatdutta/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/saswatdutta/.sdkman/bin/sdkman-init.sh"
