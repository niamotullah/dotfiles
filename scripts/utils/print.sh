#!/bin/bash

# Text color variables
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m' # Reset color

# Message types
INFO="[INFO]"
WARN="[WARN]"
ERROR="[ERROR]"
SUCCESS="[SUCCESS]"
DEBUG="[DEBUG]"

# Determine the root config directory (for example, where deploy.sh is located)
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DOTFILES_DIR="$SCRIPT_DIR" # Assume that the script is in the root of the config directory

# Create logs directory if it doesn't exist
LOG_DIR="$DOTFILES_DIR/logs"
mkdir -p "$LOG_DIR"

# Generate log file name with a datetime suffix
LOG_FILE="$LOG_DIR/deploy_$(date '+%Y%m%d_%H%M%S').log"

# Print an error message
printErr() {
	echo -e "${RED} ${ERROR} ${RESET} $1"
	logToFile "${ERROR} $1"
}

# Print a warning message
printWarn() {
	echo -e "${YELLOW} ${WARN} ${RESET} $1"
	logToFile "${WARN} $1"
}

# Print a success message
printSuccess() {
	echo -e "${GREEN}${SUCCESS}${RESET} $1"
	logToFile "${SUCCESS} $1"
}

# Print an informational message
printInfo() {
	echo -e "${CYAN}${INFO}${RESET} $1"
	logToFile "${INFO} $1"
}

# Print a debug message (only if DEBUG_MODE is enabled)
printDebug() {
	if [ "$DEBUG_MODE" = "true" ]; then
		echo -e "${CYAN}${DEBUG}${RESET} $1"
		logToFile "${DEBUG} $1"
	fi
}

# Function to log messages to a file
logToFile() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >>"$LOG_FILE"
}

# Example of usage:
# To use the script, you can call the functions like this:
# printSuccess "Deployment completed."
# printErr "Source file does not exist."
# printInfo "Processing file xyz."
# printDebug "Debugging variable value: $var"
