#!/bin/bash

# Ensure script runs with sudo privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)." 
   exit 1
fi

# Install Zsh
echo "Installing Zsh..."
dnf install -y zsh

# Change default shell to Zsh for the current user
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh) $(whoami)

echo "Installing Plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install VLC and multimedia codecs
echo "Installing VLC and multimedia codecs..."
dnf install -y vlc ffmpeg gstreamer1-plugins-{bad-free,good,ugly-free} \
               gstreamer1-plugin-openh264 mozilla-openh264 \
               lame libdvdcss

# Reload shell
echo "Installation complete! Restart your session or run 'exec zsh' to start using Zsh."

echo "Add Plugins in .zshrc file"
