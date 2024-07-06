# iTerm2 & Zsh Command Cheat Sheet for Workhelix Full-Stack Engineers

## iTerm2 Commands

*   **Navigation:**
    *   `Cmd + T`: New tab
    *   `Cmd + W`: Close tab
    *   `Cmd + [`/`]`: Previous/next tab
    *   `Cmd + D`: Split vertically
    *   `Cmd + Shift + D`: Split horizontally
    *   `Cmd + Opt + Arrow`: Move between split panes

*   **Search & Efficiency:**
    *   `Cmd + F`: Search
    *   `Cmd + Shift + F`: Search across all open sessions

## Zsh Aliases and Functions (From .zshrc)

### Git

*   `g`: Short for `git`
*   `ga`: `git add`
*   `gaa`: `git add --all`
*   `gs`: `git status`
*   `gc`: `git commit -v` (verbose commit)
*   `gco`: `git checkout`
*   `gb`: `git branch`
*   `gd`: `git diff`
*   `gf`: `git fetch`
*   `gp`: `git push`
*   `gl`: `git pull`
*   `glog`: `git log --oneline --decorate --graph` (visual log)

### Python Development

*   `py`: `python3`
*   `pip`: `pip3`
*   `venv`: Create a virtual environment
*   `activate`: Activate the virtual environment (replace `venv` with your actual environment name)

### Node.js Development

*   `npms`: `npm start`
*   `npmt`: `npm test`
*   `npmr`: `npm run`
*   `npmi`: `npm install`
*   `npmu`: `npm update`

### Docker

*   `d`: Short for `docker`
*   `dc`: `docker-compose`
*   `dps`: `docker ps` (list containers)
*   `dimages`: `docker images`

### Utility

*   `dud`: Disk usage of directories (`du -d 1 -h`)
*   `duf`: Disk usage of files (`du -sh *`)
*   `fd`: Find directories (uses `fd` if installed, otherwise `find`)
*   `ff`: Find files (uses `fd` if installed, otherwise `find`)
*   `mkcd [name]`: Create directory and `cd` into it
*   `backup [file]`: Backs up a file (e.g., `backup app.py`)
*   `extract [archive]`: Extract archives (.zip, .tar.gz, etc.)

### Environment Management

*   `use_system_python`: Switch to the system's default Python installation
*   `use_pyenv`: Activate pyenv for managing Python versions 

### Claude CLI (for Workhelix-Specific Tasks)

*   `claude [query]`: Ask Claude a question using the default context
*   `claude_project [project_name]`: Set context, index, and summarize a project
*   `claude_save [name]`: Save Claude's response
*   `swc`: Set work context (alias for `set_work_context`)
*   `ccc`: Clear Claude context (alias for `clear_claude_context`)
*   `cw [query]`: Ask Claude using work context

## Additional Useful Commands

*   `htop`: Monitor system resources and processes
*   `lsof -i :[port]`: Check which process is using a port (e.g., `lsof -i :8000`)

*   **Copy file contents to clipboard:** `pbcopy < filename.txt`
*   **Copy command output to clipboard:** `command | pbcopy`



## Workflow Examples (Tailored for Your Workhelix Context)

### FastAPI Backend Development

1.  **Navigate to your project:** `z my_fastapi_project`
2.  **Activate virtual environment:** `activate` (assuming your environment is named "venv")
3.  **Start development server:** `uvicorn main:app --reload` 
4.  **Open another tab (iTerm2):** `Cmd + T`
5.  **Run tests:** `pytest` 
6.  **Switch between tabs:** `Cmd + [` or `Cmd + ]`

### React Frontend Development

1.  **Navigate to your project:** `z my_react_project`
2.  **Start development server:** `npm start`
3.  **Open another tab (iTerm2):** `Cmd + T`
4.  **Run tests:** `npm test` or `jest`
5.  **Switch between tabs:** `Cmd + [` or `Cmd + ]` 
6.  **Install a new package:** `npmi package-name`

### Cloud Operations (AWS)

1.  **Check running containers:** `dps`
2.  **SSH into an EC2 instance:** `ssh -i my_key.pem ec2-user@public_ip`
3.  **Query RDS instance status:** `aws rds describe-db-instances`
4.  **Log into AWS console:** `aws sso login` (if using AWS SSO)

## Tips & Tricks

*   **fzf:** Use `fzf` (`Ctrl+T`) for lightning-fast file searches within projects.
*   **`z`:** Use the `z` command to quickly jump to frequented directories.
*   **`se`:** Search for a file by name and open it for editing (`se filename`).
*   **`cw`:** If you are working on the Workhelix project, quickly query Claude in your work context.
