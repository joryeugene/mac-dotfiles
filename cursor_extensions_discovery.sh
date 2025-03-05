#!/usr/bin/env bash

# cursor_extensions_discovery.sh
# Script to discover and backup Cursor IDE extensions

DOTFILES_DIR="${HOME}/dotfiles"
CURSOR_CLI="cursor"
CURSOR_EXTENSIONS_DIR="${DOTFILES_DIR}/cursor_extensions"
EXTENSIONS_FILE="${CURSOR_EXTENSIONS_DIR}/extensions.txt"

# Create extensions directory if it doesn't exist
mkdir -p "${CURSOR_EXTENSIONS_DIR}"

echo "Discovering Cursor extensions..."

# Try using Cursor CLI first (most reliable if available)
if command -v "${CURSOR_CLI}" >/dev/null 2>&1; then
    echo "Using Cursor CLI to list extensions..."
    "${CURSOR_CLI}" --list-extensions > "${EXTENSIONS_FILE}" 2>/dev/null
    CLI_SUCCESS=$?

    if [ ${CLI_SUCCESS} -eq 0 ] && [ -s "${EXTENSIONS_FILE}" ]; then
        echo "Successfully used Cursor CLI to find extensions"
    else
        echo "Cursor CLI failed to list extensions, trying alternative methods..."
        rm -f "${EXTENSIONS_FILE}"
        CLI_SUCCESS=1
    fi
else
    echo "Cursor CLI not found, falling back to filesystem discovery..."
    CLI_SUCCESS=1
fi

# If CLI method failed, try filesystem methods
if [ ${CLI_SUCCESS} -ne 0 ]; then
    # Try common locations for Cursor extensions
    POSSIBLE_LOCATIONS=(
        "${HOME}/.cursor/extensions"
        "${HOME}/Library/Application Support/Cursor/User/extensions"
        "${HOME}/.config/Cursor/extensions"
        "${HOME}/.config/cursor/extensions"
    )

    for location in "${POSSIBLE_LOCATIONS[@]}"; do
        if [ -d "${location}" ]; then
            echo "Found extensions directory at: ${location}"
            find "${location}" -maxdepth 1 -type d -not -path "${location}" | while read -r ext_dir; do
                basename "${ext_dir}" >> "${EXTENSIONS_FILE}"
            done

            if [ -s "${EXTENSIONS_FILE}" ]; then
                echo "Successfully found extensions using filesystem method"
                break
            fi
        fi
    done
fi

# Check if we found any extensions
if [ -f "${EXTENSIONS_FILE}" ] && [ -s "${EXTENSIONS_FILE}" ]; then
    EXTENSION_COUNT=$(wc -l < "${EXTENSIONS_FILE}" | tr -d ' ')
    echo "Found ${EXTENSION_COUNT} extensions"
    echo "Extensions list saved to ${EXTENSIONS_FILE}"

    # Also create a JSON version for easier programmatic use
    JSON_FILE="${CURSOR_EXTENSIONS_DIR}/extensions.json"
    echo "{" > "${JSON_FILE}"
    echo "  \"extensions\": [" >> "${JSON_FILE}"

    # Read each line and add it to the JSON array
    while IFS= read -r extension; do
        # Add trailing comma for all but the last line
        if [ "$(tail -n 1 "${EXTENSIONS_FILE}")" != "${extension}" ]; then
            echo "    \"${extension}\"," >> "${JSON_FILE}"
        else
            echo "    \"${extension}\"" >> "${JSON_FILE}"
        fi
    done < "${EXTENSIONS_FILE}"

    echo "  ]," >> "${JSON_FILE}"
    echo "  \"timestamp\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"," >> "${JSON_FILE}"
    echo "  \"system\": \"$(uname -a)\"" >> "${JSON_FILE}"
    echo "}" >> "${JSON_FILE}"

    echo "Also created JSON version at ${JSON_FILE}"

    exit 0
else
    echo "No extensions found or unable to access extensions directory"
    echo "Please make sure Cursor is installed and you have extensions installed"
    exit 1
fi
