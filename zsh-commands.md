# iTerm2 and Zsh Command Cheat Sheet

## iTerm2 Commands

*   `Cmd + T`: New tab
*   `Cmd + W`: Close tab
*   `Cmd + [`/`]`: Previous/next tab
*   `Cmd + D`: Split vertically
*   `Cmd + Shift + D`: Split horizontally
*   `Cmd + Opt + Arrow`: Move between split panes
*   `Cmd + F`: Search
*   `Cmd + Shift + F`: Search across all open sessions

## Zsh Aliases and Functions

*   `mkcd`: Create a new directory and move into it
*   `alias g='git'`: Shorter alias for Git
*   `alias gaa='git add --all && git commit'`: Quickly add and commit everything
*   `path`: Display the current PATH variable's value
*   `alias ga='git add'`: Shorter alias for adding files to Git
*   `alias gl="git pull --rebase"`: Pull with rebase
*   `alias gd="git diff"`: View changes between working tree and index or between commits
*   `alias gc="git commit -m"`: Commit with a message in one command
*   `alias gco="git checkout"`: Checkout a different branch
*   `alias gcb="git checkout -b"`: Create and checkout a new branch
*   `alias gp="git push"`: Push current changes to remote
*   `alias gs="git status"`: View the status of the working tree
*   `alias gf="git fetch"`: Fetch changes from remote
*   `alias gpsup="git push --set-upstream origin $(current_branch)"`: Set upstream for the current branch
*   `alias gcl="git clone"`: Clone a repository
*   `alias gpom="git pull origin master"`: Pull changes from the master branch of the origin remote
*   `alias gst="git stash"`: Stash changes
*   `alias gsta="git stash apply"`: Apply stashed changes

### Additional Useful Commands

*   `stree .`: Open SourceTree for the current directory
*   `zed .`: Open Zed editor for the current directory
*   `code .`: Open Visual Studio Code for the current directory
*   `v .` or `nvim .`: Open Neovim for the current directory
*   `cot [filename]`: Open file in CotEditor

### Directory Navigation

*   `z [directory]`: Auto jump to a frequently used directory
*   `take [directory]`: Create a new directory and change to it

### Command History

*   `Ctrl + R`: Search through command history interactively

### System Monitoring

*   `htop`: Interactive process viewer and system monitor
*   `lsof -i :[port]`: List processes using a specific port
    *   Example: `lsof -i :8080`

### Clipboard Operations

*   **Copy file contents to clipboard:**
    ```bash
    pbcopy < filename.txt
    ```
*   **Copy command output to clipboard:**
    ```bash
    command | pbcopy
    ```

## Plugin Commands

### z (directory jumping)

*   Jump to a directory: `z directory_name`
*   Show directory rankings: `z -r`
*   List only directories that match: `z -l directory_name`

### fzf (fuzzy finder)

*   Fuzzy file search: `Ctrl + T`
*   Fuzzy command history search: `Ctrl + R`
*   Fuzzy directory jumping: `Alt + C`

### oh-my-zsh

*   `take [directory]`: Create a new directory and change to it

## Custom Functions from .zshrc

### Claude CLI Functions

*   `claude_project [project_name]`: Set context, index documents, and query Claude for project analysis
*   `claude_save [response_name]`: Save Claude's last response
*   `set_work_context` (alias `swc`): Set work context for Claude CLI
*   `clear_claude_context` (alias `ccc`): Clear all contexts for Claude CLI
*   `ask_claude_work` (alias `cw`): Quickly query Claude with work context

### Utility Functions

*   `mkcd [directory]`: Create a directory and change into it
*   `path`: Print PATH in a readable format
*   `backup [file]`: Create a backup of a file
*   `extract [archive]`: Extract various archive formats
*   `search_and_edit` (alias `se`): Search for a file and open it in the default editor

## Environment Management

*   `use_system_python`: Switch to system Python
*   `use_pyenv`: Switch to Pyenv-managed Python
*   `activate_claude`: Activate Claude environment
*   `deactivate_claude`: Deactivate Claude environment

## Additional Aliases

*   `update_all`: Comprehensive system update
*   `weather`: Show weather information
*   `cheat`: Access cheat sheets
*   `speedtest`: Run a speed test
*   `pubip`: Show public IP address
*   `localip`: Show local IP address

## Tips and Tricks

1.  Use `Ctrl + R` for reverse history search.
2.  Leverage `z` for quick directory navigation.
3.  Utilize `fzf` for fuzzy finding files and commands.
4.  Use `extract` function for easy archive extraction.
5.  Employ `search_and_edit` (alias `se`) to quickly find and edit files.
