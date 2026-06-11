#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_completion.sh
source $HOME/.bash_profile

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

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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
alias gac-vpn="awk -F': '  '/^senha:/ {print $2}' ~/crucial-ssd/GAC/credentials && sudo openvpn --config ~/crucial-ssd/GAC/new-vpn.ovpn --daemon"

# --- Aliases End ---

# --- Bind ---

# bind '"\C-t": reverse-search-history'
# bind -r "\C-l"

# --- Bind End ---
# . "$HOME/.cargo/env"

PS1="\[\e[1;36m\]\u@\h \W -> \[\e[m\]"
PS2="\[\e[1;36m\]> \[\e[m\]"

# pnpm
export PNPM_HOME="/home/fellipe/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
. "/home/fellipe/.deno/env"
source /home/fellipe/.local/share/bash-completion/completions/deno.bash
