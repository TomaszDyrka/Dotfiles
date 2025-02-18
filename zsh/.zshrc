# Lines configured by zsh-newuser-install
HISTFILE=~/Dotfiles/zsh/.histfile
HISTSIZE=1000
SAVEHIST=2000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

eval "$(starship init zsh)"
