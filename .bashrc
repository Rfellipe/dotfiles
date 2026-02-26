#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- Exports ---
# export TZ=America/Sao_Paulo

# Fix locale error

# export LANG=en_US.UTF-8

# Add vim as editor
export EDITOR=/usr/bin/nvim

# Add local binaries to path
export PATH=$HOME/.local/bin:$PATH

# Export Projects folder
export PROJECTS="/home/fellipe/Projects"

# GoLang to PATH
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

# Export pnpm global bins
export PNPM_HOME="/home/fellipe/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# --- Exports End ---

# --- Aliases ---

alias nvim_config='cd $HOME/.config/nvim; nvim .'
alias get_esprs='. $HOME/.export-esp.sh'
alias size='du -hs'
alias waybar-reset='killall -SIGUSR2 waybar'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='sudo pacman'
alias zephyr-docker='docker run --rm -ti \
  -v "$PWD":/workdir \
  --device=/dev/ttyUSB0:/dev/ttyUSB0 \
  --group-add $(stat -c "%g" /dev/ttyUSB0) \
  docker.io/zephyrprojectrtos/zephyr-build:main'

# --- Aliases End ---

# --- Bind ---

# bind '"\C-t": reverse-search-history'
# bind -r "\C-l"

# --- Bind End ---
# . "$HOME/.cargo/env"

PS1="\[\e[1;36m\]\u@\h \W -> \[\e[m\]"
PS2="\[\e[1;36m\]> \[\e[m\]"
