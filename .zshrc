export PATH=.:$HOME/bin:/usr/local/bin:$PATH
export ZSH=/usr/share/oh-my-zsh
export ZSH_THEME="rkj-repos"
export HIST_STAMPS="yyyy-mm-dd"
export LANG="fr_FR.UTF-8"
export SHELL="zsh"
export MONITOR=$(polybar --list-monitors 2> /dev/null | cut -f1 -d':')
export WIRELESS=$(ip link | cut -f2 -d':' | grep wl | tr -d ' ')
export WIRED=$(ip link | cut -f2 -d':' | grep en | tr -d ' ')

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