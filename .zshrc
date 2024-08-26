# Source Zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# User configuration
export EDITOR='nvim'

# Load Starship prompt
eval "$(starship init zsh)"

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# Load plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light agkozak/zsh-z

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Vi mode settings
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup and for each new prompt
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Aliases and functions (load from separate files)
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^R' fzf-history-widget
bindkey '^O' fzf-cd-widget

# Colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Load environment variables and API keys
[[ -f "$HOME/.env" ]] && source "$HOME/.env"

# Additional PATH and environment variables
export PATH="$PATH:/Users/jory/.local/bin"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/opt/libpq/lib"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"

# Optimize direnv
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# System-wide environment settings for zsh
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# Function to backup config files
backup_configs() {
  local dotfiles_dir="$HOME/dotfiles"
  mkdir -p "$dotfiles_dir"

  local files=(
    "$HOME/.zshrc"
    "$HOME/.config/starship.toml"
    "$HOME/.config/nvim/init.vim"
    "$HOME/Library/Application Support/Cursor/User/profiles/48fc2b27/keybindings.json"
    "$HOME/Library/Application Support/Cursor/User/profiles/48fc2b27/settings.json"
  )

  for file in "${files[@]}"; do
    if [ -f "$file" ]; then
      cp "$file" "$dotfiles_dir/$(basename "$file")"
      echo "Backed up $file"
    else
      echo "Warning: $file not found"
    fi
  done

  echo "Backup complete. Files saved in $dotfiles_dir"
}

# Load any local customizations
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
