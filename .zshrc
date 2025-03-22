# Initialize Zinit if available
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

# Run neofetch on terminal startup
if command -v neofetch &> /dev/null; then
    neofetch
fi

if [ -f "$ZINIT_HOME/zinit.zsh" ]; then
    source "$ZINIT_HOME/zinit.zsh"
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit
else
    echo "Zinit not found. Install with: sh -c "$(curl -fsSL https://git.io/zinit-install)""
fi

# Load environment variables from ~/.env
if [ -f "$HOME/.env" ]; then
  set -a
  source "$HOME/.env"
  set +a
fi

# Core environment settings
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export FUNCNEST=100

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .DS_Store'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .DS_Store"

# Enhanced preview options
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range :500 {}'
  --preview-window 'right:60%'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'Press CTRL-/ to toggle preview'
  --prompt '🔍 '
  --pointer '▶'
  --marker '✓'
"

export FZF_ALT_C_OPTS="
  --preview 'tree -C {} | head -200'
  --preview-window 'right:60%'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'Press CTRL-/ to toggle preview'
  --prompt '📁 '
  --pointer '▶'
  --marker '✓'
"

# Load plugins with Zinit
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

# Function to update cursor and Starship keymap
function update_vim_mode() {
    case ${KEYMAP} in
        vicmd)
            echo -ne '\e[2 q'  # Block cursor
            STARSHIP_SHELL_KEYMAP=NORMAL
            ;;
        main|viins)
            echo -ne '\e[5 q'  # Beam cursor
            STARSHIP_SHELL_KEYMAP=INSERT
            ;;
    esac
}

# Set up Zle hooks
function zle-line-init zle-keymap-select {
    update_vim_mode
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Use beam shape cursor on startup and for each new prompt
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q'; }

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Enhanced history configuration
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first
setopt HIST_IGNORE_DUPS         # Don't record duplicates
setopt HIST_IGNORE_SPACE        # Don't record entries starting with space
setopt HIST_VERIFY              # Show command with history expansion
setopt SHARE_HISTORY            # Share history between sessions
setopt APPEND_HISTORY           # Append to history file

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^R' fzf-history-widget
bindkey '^F' fzf-cd-widget
bindkey '^T' fzf-file-widget

# Colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Load aliases and functions
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# PATH configuration
path=(
    $HOME/.local/bin
    /opt/homebrew/opt/postgresql@16/bin
    $path
)
export PATH

# Development environment variables
export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/opt/libpq/lib"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"

# System-wide environment settings for zsh
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# Load any local customizations
# [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Load Cargo environment
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Initialize Starship prompt (keep at end)
eval "$(starship init zsh)"
