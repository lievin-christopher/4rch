export PATH=.:$HOME/bin:/usr/local/bin:$PATH
export ZSH=~/.oh-my-zsh
export ZSH_THEME="rkj-repos"
export HIST_STAMPS="yyyy-mm-dd"
export LANG="fr_FR.UTF-8"
export SHELL="zsh"

plugins=(git)
source $ZSH/oh-my-zsh.sh



# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='micro'
 else
   export EDITOR='nano'
fi

#aliases
alias music='ncmpcpp'
alias firefox='firefox-developer-edition'

screenfetch