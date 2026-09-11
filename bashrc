#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_completion
source $HOME/.bash_profile

# --- Exports ---

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

# Add neovim as editor
export EDITOR=/usr/bin/nvim

# Add local binaries to path
export PATH=$HOME/.local/bin:$PATH

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
alias size='du -hs'
alias waybar-reset='killall -SIGUSR2 waybar'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='sudo pacman'
alias zwest='source $PROJECTS/C/ZephyrWorkspace/.venv/bin/activate'

# --- Aliases End ---
