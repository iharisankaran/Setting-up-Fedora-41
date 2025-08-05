#!/bin/bash

# Fedora 42 Productivity Setup Script
# Author: ChatGPT + You 😎

echo "🛠️ Starting Fedora 42 Productivity Setup..."

# Update system
echo "🔄 Updating system..."
sudo dnf upgrade --refresh -y

# Install Flatpak + Flathub
echo "📦 Setting up Flatpak & Flathub..."
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Enable RPM Fusion (Free + Non-Free)
echo "🎞️ Enabling RPM Fusion Repos..."
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install Brave Browser
echo "🌐 Installing Brave Browser..."
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave.com/linux/rpm/
sudo rpm --import https://brave.com/static-assets/downloads/brave-core.asc
sudo dnf install -y brave-browser

# Install VS Code (Microsoft official repo)
echo "💻 Installing Visual Studio Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

# Install VLC from RPM Fusion
echo "🎬 Installing VLC media player..."
sudo dnf install -y vlc

# Install Telegram (Flatpak)
echo "💬 Installing Telegram Desktop (Flatpak)..."
flatpak install -y flathub org.telegram.desktop

# Install Foliate (Flatpak)
echo "💬 Installing Foliate (Flatpak)..."
flatpak install flathub com.github.johnfactotum.Foliate

#Install Blanket (Flatpak)
echo "💬 Installing Blanket (Flatpak)..."
flatpak install flathub com.rafaelmardojai.Blanket

#Install Quick Lookup (Flatpak)
echo "💬 Installing Blanket (Flatpak)..."
flatpak install flathub com.github.johnfactotum.QuickLookup

# Optional Tools (Uncomment if needed)
# echo "🔧 Installing Gnome Tweaks..."
# sudo dnf install -y gnome-tweaks

# echo "📂 Installing Git & Curl..."
# sudo dnf install -y git curl

echo "✅ All apps installed successfully!"
echo "📦 You can now reboot to finalize Flatpak integration."

