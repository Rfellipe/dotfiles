#!/usr/bin/env bash
# My Dotfiles Installation Script

# Verbose ln, because `ln -v` is not portable
symlink() {
  printf '%55s -> %s\n' "${1/#$HOME/\~}" "${2/#$HOME/\~}"
  ln -nsf "$@"
}

install() {
  if [$1 == "" ]; then
    return 1
  fi

  echo "Installing $1"
  sudo pacman -S $1 --noconfirm
  return 0
}

echo "Start git submodule? [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
  git submodule init
  git submodule update
fi

DEPENDENCIES=("hyprland" "neovim" "curl" "rofi" "waybar" "kitty" "swaync" "cliphist" "base-devel" "zip" "unzip" "tar" "lazygit" "ripgrep" "hyprpaper" "fd")
DOTS=("fastfetch" "hypr" "kitty" "nvim" "rofi" "systemd" "waybar" ".bashrc" ".gitconfig")
CONFIG_DIR="$HOME/.config"

echo "Install all dependencies? [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
  sudo pacman -Syyu "${DEPENDENCIES[@]}" --noconfirm

  if ! type "$nvm" >/dev/null; then
    echo "Installing NVM (Node Version Manager)"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | sh

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi

  if ! type "$node" >/dev/null; then
    echo "Installing Node.JS and NPM"
    nvm install --lts
  fi
fi

for dfs in "${DOTS[@]}"; do
  target="${CONFIG_DIR}/$dfs"
  src="$PWD/$dfs"
  backup_root="${CONFIG_DIR}/.dots.bak/"

  if [[ "$dfs" == ".bashrc" || "$dfs" == ".gitconfig" ]]; then
    echo "Creating symlink of $dfs"
    rm "$HOME/$dfs"
    symlink "$src" "$HOME/$dfs"
    continue
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    # if it's already the correct symlink, skip
    if [[ -L "$target" && "$(readlink -- "$target")" == "$src" ]]; then
      continue
    fi

    mkdir -p "$backup_root/$(dirname "$dfs")"
    mv -f -- "$target" "$backup_root/$dfs"
  fi

  symlink "$src" "$target"
done
