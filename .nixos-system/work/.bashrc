#  ~/.bashrc

export PATH=$PATH:$HOME/.local/share/bin
export PATH=$PATH:$HOME/.npm-packages/bin
export PATH=$HOME/bin:/usr/bin:$PATH
export PATH=$HOME/.node_modules/bin:$PATH
export GTK_PATH=$HOME/.nix-profile/lib/gtk-2.0
export MANPATH="${MANPATH-$(manpath)}:~/.npm-packages/share/man"


export ALTERNATE_EDITOR="nvim"
export EDITOR="emacsclient -c"
export VISUAL=$EDITOR

alias vim="nvim"



if [ "$(tty)" = "/dev/tty1" ]; then
    # Auto mount hdd
    hdd-up
	  exec sway
fi
