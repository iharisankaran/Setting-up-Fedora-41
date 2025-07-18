# Setup Git

### Copy git_setup.sh code && run in local machine
```bash
nano git_setup.sh

chmod +x git_setup.sh

./git_setup.sh
```

### After that run below command
```bash
ls ~/.ssh/id_ed25519.pub
```
### Add the SSH key to GitHub:
```bash
cat ~/.ssh/id_ed25519.pub
```
* Copy the output and go to GitHub → Settings → SSH and GPG keys → New SSH Key.

### Test the SSH connection:
```bash
ssh -T git@github.com
```
# Install ZSH && Starship
```bash
chmod +x install_zsh_starship.sh

./install_zsh_starship.sh
```
# To install other apps
```bash
chmod +x fedora-prod-setup.sh

./fedora-prod-setup.sh
```
