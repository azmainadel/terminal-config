#!/usr/bin/env bash
# setup-shell-mac.sh
# Fresh macOS shell setup: oh-my-zsh + powerlevel10k + autosuggestions + syntax-highlighting
# Re-run safe (skips already-installed/cloned things).

set -e

# 1. Homebrew (skip if already installed)
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon path; adjust if Intel (/usr/local/bin)
fi

# 2. deps + a Nerd Font (p10k icons need this on the LOCAL terminal app)
brew install git zsh
brew install --cask font-meslo-lg-nerd-font

# 3. oh-my-zsh (unattended)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# 4. powerlevel10k
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
sed -i '' 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# 5. plugins: autosuggestions + syntax-highlighting
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
sed -i '' 's|plugins=(git)|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|' ~/.zshrc

# 6. cache completions (compinit re-scans from scratch every launch otherwise — slows prompt)
if ! grep -q 'compinit -C' ~/.zshrc; then
  cat >> ~/.zshrc <<'EOF'

# cached completion init (faster startup than re-scanning every shell)
autoload -Uz compinit
compinit -C
EOF
fi

echo ""
echo "Done. Restart your terminal, then:"
echo "1. Set your terminal app's font to 'MesloLGS NF' (needed for p10k icons)"
echo "2. Run 'p10k configure' to set up the prompt"
