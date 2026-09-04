#!/usr/bin/env bash
# setup-shell.sh
# Fresh VM shell setup: oh-my-zsh + powerlevel10k + autosuggestions + syntax-highlighting
# Run on a clean Ubuntu VM. Re-run safe (skips already-cloned repos).

set -e

# 1. deps
sudo apt update
sudo apt install -y zsh git curl fontconfig

# 2. oh-my-zsh (unattended, won't drop into a new shell mid-script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# 3. powerlevel10k theme
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# 4. plugins: autosuggestions + syntax-highlighting
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
sed -i 's|plugins=(git)|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|' ~/.zshrc

# 5. Ghostty terminfo fix
# Local Mac terminal (Ghostty) sends TERM=xterm-ghostty, which the VM's terminfo
# db doesn't know -> breaks `clear` and other terminal-aware commands.
# Fall back to xterm-256color, which covers colors/cursor movement/clear fine.
if ! grep -q 'xterm-ghostty' ~/.zshrc; then
  echo '[[ "$TERM" == "xterm-ghostty" ]] && export TERM=xterm-256color' >> ~/.zshrc
fi

# 6. make zsh the default shell
chsh -s "$(which zsh)"

echo ""
echo "Done. Log out and back in (or run 'zsh') to start using it."
echo "p10k config wizard launches automatically on first zsh run."
echo "Local terminal (Mac) still needs a Nerd Font set for p10k's icons to render."
