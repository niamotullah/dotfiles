#!/bin/bash



# Function to check if a file or directory exists
is_exists() {
    local path=$1

    if [ -e "$path" ]; then
        return 0
    else
        return 1
    fi
}

