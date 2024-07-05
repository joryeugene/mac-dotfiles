# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Set plugins
plugins=(
    git zsh-autosuggestions zsh-syntax-highlighting z vi-mode fzf
    history-substring-search colored-man-pages docker kubectl pyenv npm
    command-not-found web-search extract
)

# Oh My Zsh configuration
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"
export UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF configuration
export FZF_BASE=$(brew --prefix)/opt/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
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

# Aliases
alias zshconfig='$EDITOR ~/.zshrc'
alias ohmyzsh='$EDITOR ~/.oh-my-zsh'
alias nvimconfig='$EDITOR ~/.config/nvim/init.vim'
alias sourcezsh='source ~/.zshrc && echo "ZSH config reloaded!"'
alias update='brew update && brew upgrade && npm update -g && omz update'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias myip='curl http://ipecho.net/plain; echo'
alias ports='netstat -tulanp'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# List directory contents
alias ls='ls -GFh'
alias ll='ls -lAFh'
alias la='ls -A'
alias l='ls -CF'

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gs='git status'
alias gc='git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'

# Vim/Neovim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dimages='docker images'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'

# Node.js
alias npms='npm start'
alias npmt='npm test'
alias npmr='npm run'
alias npmi='npm install'
alias npmu='npm update'

# Utility
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Custom functions
function mkcd() {
  mkdir -p "$@" && cd "$_";
}

function path(){
  echo $PATH | tr ':' '\n' | nl
}

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Syntax highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[argument]='fg=white'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'

# Custom oh-my-zsh title
DISABLE_AUTO_TITLE="true"
function _set_terminal_title() {
    echo -ne "\033]0;${PWD##*/}\007"
}
precmd_functions+=(_set_terminal_title)

# Load environment variables and API keys
if [ -f "$HOME/.env" ]; then
    set -a
    source "$HOME/.env"
    set +a
fi

# Claude CLI functions
function claude_project() {
    local project_name=$1
    local context_path="$HOME/projects/$project_name/docs"
    local claude_cli="$HOME/scripts/claude_cli.py"
    
    python3 "$claude_cli" --set-context-path "$context_path" && \
    python3 "$claude_cli" --index && \
    python3 "$claude_cli" "Analyze the documents in the context path and summarize the main features of the project they describe. Focus on providing a concise overview highlighting key aspects."
}

function claude_clear_index() {
    $HOME/claude_env/bin/python3 $HOME/scripts/claude_cli.py --clear-index
}

function claude_query() {
    $HOME/claude_env/bin/python3 $HOME/scripts/claude_cli.py "$1"
}

function claude_stream() {
    $HOME/claude_env/bin/python3 $HOME/scripts/claude_cli.py --stream "$1"
}

function claude_save() {
    $HOME/claude_env/bin/python3 $HOME/scripts/claude_cli.py --save "$1"
}

alias claude='$HOME/claude_env/bin/python3 $HOME/scripts/claude_cli.py'
alias claude_roles='$HOME/claude_env/bin/python3 $HOME/scripts/claude_cli.py --list-roles'
alias activate_claude='source $HOME/claude_env/bin/activate'
alias deactivate_claude='deactivate'

# Python environment management
alias use_system_python='PATH=$(echo $PATH | sed -e "s|$HOME/.pyenv/shims:||g")'
alias use_pyenv='eval "$(pyenv init --path)" && eval "$(pyenv init -)"'

# Additional helpful aliases
alias update_all='brew update && brew upgrade && npm update -g && omz update && pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U'
alias weather='curl wttr.in'
alias cheat='curl cheat.sh/'
alias speedtest='speedtest-cli'
alias pubip='curl ifconfig.me'
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Function to create a backup of a file
function backup() {
    cp "$1" "$1.bak"
    echo "Backup created: $1.bak"
}

# Function to extract various archive formats
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Function to search for a file and open it with the default editor
function search_and_edit() {
    local file=$(find . -type f -name "*$1*" | fzf)
    if [[ -n $file ]]; then
        $EDITOR "$file"
    else
        echo "No file found matching '$1'"
    fi
}
alias se='search_and_edit'

# Load any local customizations
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

