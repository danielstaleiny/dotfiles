  export ZSH=/home/anon/.oh-my-zsh
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambda-gitster"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export EDITOR='emacs'
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/rsa_id"

if [ $TILIX_ID ] | [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

tldr_path="$(which tldr)"
function tldr() {
	eval "$tldr_path" $@ "--color"
}


export PATH=~/.local/bin:$PATH
export PATH=~/.gem/ruby/2.5.0/bin:$PATH
export PATH=~/.nix-profile/bin:$PATH
export PATH=~/env/bin:$PATH
#export PATH=~/env/lib/python3.7/site-packages:$PATH

export PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

export LD_LIBRARY_PATH=/usr/lib32/nvidia:/usr/lib/nvidia:$LD_LIBRARY_PATH

alias prod='ssh daniel@collageofficial.com'
alias staging='ssh daniel@staging.collageofficial.com'
alias eatmybackyard='ssh daniel@eatmybackyard.dk'
alias e='exit'
alias cc='clear'
alias gs='git status -sb'
alias weather='curl "wttr.in/copenhagen?q"'
alias grep='rg'
alias vpnup='wg-quick up mullvad-se1'
alias vpndown='wg-quick down mullvad-se1'
alias example='tldr -t base16'
alias r='ranger'
alias h='ghc -dynamic'
alias p='sudo pacman'
alias y='yaourt'
alias cat='bat'
alias psc='psc-package'
alias pl='pulp --psc-package'
alias d='docker'
alias dc='docker-compose'

