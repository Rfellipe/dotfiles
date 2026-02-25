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
  sudo pacman -S $1 --no-confirm
  return 0
}

echo "Start git submodule? [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
  git submodule init
  git submodule update
fi

DEPENDENCIES=("hyprland" "neovim" "curl" "rofi" "waybar" "kitty")
DOTS=("fastfetch" "hypr" "kitty" "nvim" "rofi" "systemd" "waybar")
CONFIG_DIR="$HOME/.config"

echo "Install all dependencies? [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
  sudo pacman -Syyu "${DEPENDENCIES[@]}" --no-confirm
fi

for dfs in "${DOTS[@]}"; do
  target="${CONFIG_DIR}/$dfs"
  src="$PWD/$dfs"
  backup_root="${CONFIG_DIR}/.dots.bak/"

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
