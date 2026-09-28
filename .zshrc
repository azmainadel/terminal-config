# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to the Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Plugins installed
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# For a full list of active aliases, run `alias`.
alias zconf="nano ~/.zshrc"
alias python="python3"
alias hm="cd ~"
alias c="clear"
alias x="exit"
alias ls="ls -la --color=auto"

# cached completion init (faster startup than re-scanning every shell)
autoload -Uz compinit
compinit -C

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)

# port lister
ports() {
  {
    printf 'PORT\tPID\tCOMMAND\tDIRECTORY\n'
    lsof -nP -iTCP -sTCP:LISTEN -Fpcn +c0 |
    awk '/^p/{pid=substr($0,2)} /^c/{cmd=substr($0,2)}
         /^n/{n=substr($0,2); sub(/.*:/,"",n); print n"\t"pid"\t"cmd}' |
    sort -un |
    while IFS=$'\t' read -r port pid cmd; do
      cwd=$(lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')
      printf '%s\t%s\t%s\t%s\n' "$port" "$pid" "$cmd" "${cwd/#$HOME/~}"
    done | sort -t $'\t' -k4,4 -k1,1n
  } | column -t -s $'\t' |
  awk 'NR==1{printf "\033[1;36m%s\033[0m\n",$0; next} 1'
}

# pnpm
export PNPM_HOME='/Users/adel/Library/pnpm'
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
