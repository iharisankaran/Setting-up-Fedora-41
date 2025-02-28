#!/bin/bash

echo "🛠️ Setting up Git & GitHub on Fedora..."

# 1. Install Git
if ! command -v git &> /dev/null; then
    echo "🚀 Installing Git..."
    sudo dnf install git -y
else
    echo "✅ Git is already installed."
fi

# 2. Configure Git
read -p "Enter your Git username: " GIT_USERNAME
git config --global user.name "$GIT_USERNAME"

read -p "Enter your Git email: " GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

echo "✅ Git configured with:"
git config --global --list

# 3. Generate SSH Key
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
    echo "✅ SSH key already exists."
else
    echo "🔑 Generating a new SSH key..."
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY" -N ""
fi

# 4. Start SSH agent and add key
echo "🔄 Adding SSH key to SSH agent..."
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# 5. Show the SSH Key
echo "🔑 Copy this SSH key and add it to GitHub (https://github.com/settings/keys):"
cat "$SSH_KEY.pub"

# 6. Test GitHub Connection
echo "🧪 Testing GitHub SSH connection..."
ssh -T git@github.com

echo "✅ Git & GitHub setup completed! 🚀"

#Copy the SSH key it prints and add it to GitHub under Settings → SSH and GPG keys.

#ssh -T git@github.com.
