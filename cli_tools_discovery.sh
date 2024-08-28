#!/bin/bash

echo "Discovering CLI tools..."

# Get all directories in PATH
IFS=':' read -ra PATH_DIRS <<< "$PATH"

# Find all executable files in PATH directories
for dir in "${PATH_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        find "$dir" -type f -perm +111 -print0 | xargs -0 -n1 basename
    fi
done | sort -u > cli_tools_all.txt

echo "CLI tools discovery complete. Results saved in cli_tools_all.txt"
