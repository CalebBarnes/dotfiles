#!/bin/zsh

# Define the path to the scripts directory
SCRIPTS_DIR="./scripts"

# Define the script to exclude from execution
EXCLUDE_SCRIPT1="run_all.zsh" 
EXCLUDE_SCRIPT2="setup_new_system.zsh"

# Color definitions
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RESET="\033[0m"

# Execute each script
echo "${COLOR_YELLOW}Executing all scripts...${COLOR_RESET}"
for script in $SCRIPTS_DIR/*.{sh,zsh}(N); do
    # Extract just the filename from the path
    SCRIPT_NAME=$(basename "$script")

  # Skip the script if it matches any exclude patterns
    if [[ "$SCRIPT_NAME" == "$EXCLUDE_SCRIPT1" || "$SCRIPT_NAME" == "$EXCLUDE_SCRIPT2" ]]; then
        echo "${COLOR_YELLOW}Skipping $script...${COLOR_RESET}"
        continue
    fi

    echo "${COLOR_GREEN}Running $script...${COLOR_RESET}"
    $script
    echo "${COLOR_GREEN}$script completed.${COLOR_RESET}"
done

echo "${COLOR_GREEN}Running setup_new_system.zsh...${COLOR_RESET}"
./scripts/setup_new_system.zsh
echo "${COLOR_GREEN}setup_new_system.zsh completed.${COLOR_RESET}"

echo "${COLOR_YELLOW}All scripts have been executed.${COLOR_RESET}"
