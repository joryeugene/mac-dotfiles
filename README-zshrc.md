# Zsh Configuration

This README documents the custom configurations, aliases, and functions in the `.zshrc` file, along with installation steps and common workflow examples.

## Installation

1. **Install Zsh:**
   ```bash
   sudo apt install zsh
   ```

2. **Set Zsh as your default shell:**
   ```bash
   chsh -s $(which zsh)
   ```

3. **Install Oh My Zsh:**
   ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

4. **Install Powerlevel10k theme:**
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```

5. **Install plugins:**
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

6. **Update your `.zshrc`:**
   ```bash
   ZSH_THEME="powerlevel10k/powerlevel10k"
   plugins=(git zsh-autosuggestions zsh-syntax-highlighting z vi-mode fzf history-substring-search colored-man-pages docker kubectl pyenv npm command-not-found web-search extract)
   ```

7. **Install additional tools:**
   ```bash
   brew install fzf ripgrep fd
   ```

8. **Configure Powerlevel10k:**
   ```bash
   p10k configure
   ```

## Oh My Zsh Configuration

- **Theme:** Powerlevel10k
- **Plugins:** git, zsh-autosuggestions, zsh-syntax-highlighting, z, vi-mode, fzf, history-substring-search, colored-man-pages, docker, kubectl, pyenv, npm, command-not-found, web-search, extract

## Key Bindings

- Vi mode enabled
- `ctrl-e`: Edit command line in vim
- `^[[A` / `^[[B`: Up/down in history search (default)
- `vicmd 'k'` / `vicmd 'j'`: Up/down in history search (vi mode)

## Aliases and Functions

_**(Include your existing aliases and functions section here)** _

## Common Workflow Examples

1. **Navigate and search directories:**
   ```bash
   z project_dir
   fd -t d node_modules
   ```

2. **Find and edit files:**
   ```bash
   se config
   vim $(fzf)
   ```

3. **Git workflow:**
   ```bash
   gs
   gaa
   gc -m "Update feature"
   gp
   ```

4. **Python development:**
   ```bash
   venv
   activate
   py script.py
   ```

5. **Node.js development:**
   ```bash
   npmi express
   npms
   ```

6. **Docker operations:**
   ```bash
   dps
   d exec -it container_name bash
   ```

7. **System updates:**
   ```bash
   update_all
   ```

8. **Quick file operations:**
   ```bash
   mkcd new_project
   backup important_file.txt
   extract archive.tar.gz
   ```

9. **Use Claude CLI:**
   ```bash
   claude_project my_project
   claude_query "Explain the main features of this project"
   claude_save "project_summary"
   ```

## Environment Variables

The configuration loads environment variables from a `.env` file in the home directory.

## Additional Configurations

- NVM (Node Version Manager) configuration
- Pyenv configuration
- FZF configuration
- Syntax highlighting settings
- Custom Oh My Zsh title

## Notes

- Ensure that all required tools (Oh My Zsh, Powerlevel10k, etc.) are installed.
- Some configurations may need to be adjusted based on your specific setup and preferences.
- For more detailed information on each plugin or tool, refer to their respective documentation.
