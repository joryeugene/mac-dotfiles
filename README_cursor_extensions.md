# Cursor IDE Extensions Management

This system helps you track, backup, and restore your Cursor IDE extensions as part of your dotfiles repository.

## How It Works

The system provides several ways to manage your Cursor extensions:

1. **Discovering Extensions**: Run `make discover_cursor_extensions` to find and record all currently installed Cursor extensions
2. **Backing Up Extensions**: Run `make backup_configs` which will include extension backup as part of the process
3. **Installing Extensions**: When running `make configs`, the system will attempt to install all extensions from your backup

## Generated Files

When you run the extension discovery, the system generates:

- `~/dotfiles/cursor_extensions/extensions.txt` - A simple list of extension IDs
- `~/dotfiles/cursor_extensions/extensions.json` - A JSON file with extension IDs, timestamp, and system info

## Manual Commands

If you want to work with Cursor extensions directly, you can use the Cursor CLI:

```bash
# List all installed extensions
cursor --list-extensions

# Install an extension
cursor --install-extension publisher.extension-name

# Uninstall an extension
cursor --uninstall-extension publisher.extension-name
```

## Extension Installation Process

When setting up a new machine using the dotfiles:

1. Run `make all` which will install Cursor IDE (via Homebrew casks if in your list)
2. The script will attempt to install all your extensions using either:
   - The Cursor CLI (if available)
   - Manual instructions if the CLI is not available

## Troubleshooting

If extensions aren't being detected:

1. Make sure Cursor is installed
2. Check if the Cursor CLI is working by running `cursor --version`
3. If the CLI doesn't work, the script will try to find extensions in common directories:
   - `~/.cursor/extensions`
   - `~/Library/Application Support/Cursor/User/extensions`
   - Other common locations

## Manual Extension Backup

If automatic detection fails, you can get a list of extensions from Cursor:

1. Open Cursor IDE
2. Go to Extensions view
3. Note down the extension IDs you want to keep
4. Add them manually to `~/dotfiles/cursor_extensions/extensions.txt`
