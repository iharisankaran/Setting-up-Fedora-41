#!/bin/bash

echo "🚀 Starting full Zsh + Starship setup with plugins and performance tweaks..."

# Exit on error
set -e

# Step 1: Install Zsh
if ! command -v zsh &> /dev/null; then
  echo "📦 Installing Zsh..."
  sudo dnf install -y zsh
else
  echo "✅ Zsh already installed."
fi

# Step 2: Install Starship
if ! command -v starship &> /dev/null; then
  echo "📦 Installing Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
  export PATH="$HOME/.local/bin:$PATH"
else
  echo "✅ Starship already installed."
fi

# Step 3: Download and extract Meslo Nerd Font from official Nerd Fonts release
echo "🔤 Downloading Meslo Nerd Font (patched)..."

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Download the zip archive (tested working as of July 2025)
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip

# Extract only .ttf files
unzip -o Meslo.zip '*.ttf'
rm Meslo.zip

# Update font cache
fc-cache -fv
cd -

# Step 4: Install useful Zsh plugins
echo "🔌 Installing zsh-autosuggestions and zsh-syntax-highlighting..."
ZSH_CUSTOM="$HOME/.zsh_plugins"
mkdir -p "$ZSH_CUSTOM"

git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/zsh-syntax-highlighting"

# Step 5: Configure Starship
echo "⚙️  Writing Starship config..."
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
add_newline = false
format = """
$directory$git_branch$git_status$python$docker_context$kubernetes$cmd_duration$line_break$character
"""

[character]
success_symbol = "[➜](bold green) "
error_symbol = "[✗](bold red) "

[directory]
truncation_length = 3
truncate_to_repo = false
style = "cyan"
read_only = "🔒"

[git_branch]
symbol = "🌱 "
style = "purple"
format = "[$symbol$branch]($style) "

[git_status]
style = "yellow"
format = '([\[$all_status$ahead_behind\]]($style)) '

[python]
symbol = "🐍 "
style = "blue"
format = '[${symbol}${pyenv_prefix}${version}( ${virtualenv})]($style) '

[docker_context]
symbol = "🐳 "
format = "via [$symbol$context]($style) "
style = "blue"

[kubernetes]
symbol = "☸️  "
format = '[$symbol$context(\($namespace\))]($style) '
style = "blue"

[cmd_duration]
min_time = 200
format = "⏱ [$duration](yellow) "
EOF

# Step 6: Create clean .zshrc
echo "📄 Creating .zshrc..."
cat > ~/.zshrc <<EOF
# Starship prompt
eval "\$(starship init zsh)"

# Plugins
source "$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Aliases for DevOps/ML
alias k='kubectl'
alias d='docker'
alias dc='docker-compose'
alias tf='terraform'
alias pyenv='python3 -m venv venv'
alias activate='source venv/bin/activate'
alias jn='jupyter notebook'

# History & performance tweaks
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
EOF

# Step 7: Set Zsh as default shell
echo "🔧 Setting Zsh as default shell..."
if ! grep -q "$(which zsh)" /etc/shells; then
  echo "$(which zsh)" | sudo tee -a /etc/shells
fi
chsh -s "$(which zsh)"

echo "✅ All done! Please restart your terminal or run 'exec zsh'"
echo "💡 And make sure your terminal font is set to 'MesloLGS NF' for full icon support!"
