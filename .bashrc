if [ -f ~/.bash_aliases ]; then

	. ~/.bash_aliases

fi
# Created by `userpath` on 2019-05-13 17:43:03
export PATH="$PATH:/Users/saswatdutta/.local/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$HOME/.toolbox/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
