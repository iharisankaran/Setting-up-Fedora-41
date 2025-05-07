#!/bin/bash

# Fedora Cleanup and Optimization Script
# Run as root or with sudo

echo "🧹 Starting system cleanup and optimization..."

# Update packages
echo "📦 Updating packages..."
dnf upgrade --refresh -y

# Autoremove orphaned packages
echo "🗑️ Removing orphaned packages..."
dnf autoremove -y

# Clean DNF cache
echo "🧽 Cleaning DNF cache..."
dnf clean all

# Vacuum journal logs older than 7 days
echo "🧾 Trimming journal logs..."
journalctl --vacuum-time=7d

# Remove old kernels (keep 2 latest)
echo "🧯 Removing old kernels..."
dnf remove -y $(dnf repoquery --installonly --latest-limit=-2 -q) 2>/dev/null

# Btrfs balance (only if using Btrfs)
if [[ $(findmnt -n -o FSTYPE /) == "btrfs" ]]; then
    echo "⚖️ Running Btrfs balance (usage >=75%)..."
    btrfs balance start -dusage=75 -musage=75 /
else
    echo "📛 Skipping Btrfs balance (not using Btrfs filesystem)"
fi

# Status report
echo "✅ Cleanup complete."
df -h | grep -E '^Filesystem|^/dev/'

echo "✨ Done. Consider rebooting if updates were applied."
