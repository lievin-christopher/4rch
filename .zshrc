export PATH=.:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH=/usr/share/oh-my-zsh
export ZSH_THEME="rkj-repos"
export HIST_STAMPS="yyyy-mm-dd"
export LANG="fr_FR.UTF-8"
export TERMINAL="/usr/bin/alacritty"
export SHELL="/usr/bin/zsh"
export XDG_CONFIG_HOME=$HOME/.config
export MONITOR=$(xrandr --listmonitors 2> /dev/null | grep "*" | cut -f6 -d' ')
export MONITORS=$(xrandr --listmonitors 2> /dev/null | grep "+" | cut -f6 -d' ')
export WIRELESS=$(ip link | cut -f2 -d':' | grep wl | grep -v 'altname' | tr -d ' ' | head -n 1)
export WIRELESS2=$(ip link | cut -f2 -d':' | grep wl | grep -v 'altname' | tr -d ' ' | head -n 2 | tail -n 1 | grep -vE ^$WIRELESS$)
export WIRED=$(ip link | cut -f2 -d':' | grep -E 'en|eth' | grep -v 'altname' | tr -d ' ' | head -n 1)
export WIRED2=$(ip link | cut -f2 -d':' | grep -E 'en|eth' | grep -v 'altname' | tr -d ' ' | head -n 2 | tail -n 1 | grep -vE ^$WIRED$)

setopt hist_expire_dups_first # Expire duplicate entries first when trimming history.
setopt hist_save_no_dups # Don't write duplicate entries in the history file.
setopt hist_ignore_all_dups # Delete old recorded entry if new entry is a duplicate.

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
plugins=(git)



# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nano'
 else
   export EDITOR='micro'
fi

#aliases
alias ls='ls --color=auto'
alias lsd='ls --color=auto --group-directories-first'
alias ll='ls -lhA --color=auto'
alias lld='ls -lhA --color=auto --group-directories-first'
alias ip='ip -color=auto'
alias ips='ip -color=auto -br a'
alias df='df -hT'
alias free='free -h'
alias most='du -hsx * | sort -rh | head -10'         # Gives you what is using the most space. Both directories and files. Varies on current directory
alias pscpu='ps auxf | sort -nr -k 3 | head -10'     # Get top process eating cpu
alias psmem='ps auxf | sort -nr -k 4 | head -10'     # Get top process eating memory
alias ports='lsof -i -P'                             # Show open ports
alias music='ncmpcpp'
alias firefox='firefox-developer-edition'
screenfetch
