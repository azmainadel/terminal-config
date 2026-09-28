# Terminal Configuration

This repository contains my personal terminal configuration files for various terminal emulators and shell themes.

## 🔧 Usage

### Prerequisites
Install the required font:
```bash
# Install MesloLGS NF (required for both terminals)
# Download from: https://github.com/romkatv/powerlevel10k#manual-font-installation
```

### Ghostty Setup
```bash
# Copy configuration to Ghostty config directory
cp ghostty/config ~/.config/ghostty/config
```

### iTerm2 Setup
1. Open iTerm2
2. Go to **Preferences** → **Profiles**
3. Click **Other Actions** → **Import JSON Profiles**
4. Select `iterm2/default.json`
5. Set as default profile if desired

### Powerlevel10k Setup
```bash
# Install Powerlevel10k first
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Copy p10k configurations (when available)
cp p10k/.p10k.zsh ~/.p10k.zsh
```
