#!/bin/bash

echo "Discovering user-installed applications..."

# List applications in the main Applications folder
find /Applications -maxdepth 1 -type d -name "*.app" | sed 's|.*/||' | sed 's/\.app$//' > user_apps.txt

# List applications in the user's Applications folder
find ~/Applications -maxdepth 1 -type d -name "*.app" 2>/dev/null | sed 's|.*/||' | sed 's/\.app$//' >> user_apps.txt

# Sort and remove duplicates
sort -u user_apps.txt -o user_apps.txt

echo "Application discovery complete. Results saved in user_apps.txt"
