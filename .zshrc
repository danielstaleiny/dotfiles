export ZSH="/home/anon/.config/oh-my-zsh"

ZSH_THEME="lambda-gitster"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# plugins=(git colored-man-pages vi-mode node)
plugins=(git colored-man-pages node)

_comp_options+=(globdots)	

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^g' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^f' edit-command-line

#TLDR
export TLDR_HEADER='magenta bold underline'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='green'
export TLDR_CODE='red'
export TLDR_PARAM='blue'


export LANG=en_US.UTF-8



export npm_config_prefix=~/.node_modules

alias prod='ssh daniel@collageofficial.com'
alias staging='ssh daniel@staging.collageofficial.com'
alias eatmybackyard='ssh daniel@eatmybackyard.dk'
alias e='exit'
alias cc='clear'
alias ns='nix-shell'
alias ne='nixos-env'
alias nr='sudo nixos-rebuild'
alias gs='git status -sb'
alias grep='rg'
# alias vpnup='wg-quick up mullvad-se4'
# alias vpndown='wg-quick down mullvad-se4'
alias example='tldr'
# alias h='ghc -dynamic'
# alias p='sudo pacman'
# alias y='yay'
alias catt='/run/current-system/sw/bin/cat'
alias cat='bat'
# alias psc='psc-package'
# alias pl='pulp --psc-package'
alias d='docker'
alias dc='docker-compose'
alias el='eleventy'
alias dev='npm run dev'
# alias pandocread='ag -o -l -g README.md | ./eachMarkdownToOrg.sh && echo "README.org" | entr -p ./pandoc.sh /_'


source $ZSH/oh-my-zsh.sh
