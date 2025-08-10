#!/bin/bash

set -e

echo "Updating package lists and installing required packages..."
sudo apt update
sudo apt install -y kitty fish curl unzip fontconfig

echo "Changing default shell to fish..."
chsh -s $(which fish)

echo "Installing Nerd Font (FiraCode)..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd /tmp
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o FiraCode.zip -d "$FONT_DIR"
fc-cache -fv

echo "Creating kitty config..."
KITTY_CONFIG_DIR="$HOME/.config/kitty"
mkdir -p "$KITTY_CONFIG_DIR"
cat > "$KITTY_CONFIG_DIR/kitty.conf" <<EOF
background_opacity 0.85
font_family FiraCode Nerd Font
font_size 12.0
EOF

echo "Installing Fisher and bobthefish theme..."
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install oh-my-fish/theme-bobthefish"

echo "Done! Please log out and log back in to apply the default shell change."
