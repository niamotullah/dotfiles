#!/bin/bash

# Default starting directory is current directory
start_dir="$(pwd)"

# Parse command-line arguments
if [ $# -gt 0 ]; then
	# Handle trailing slashes by removing them
	clean_dir="${1%/}"

	# Convert to absolute path
	if [ -d "$clean_dir" ]; then
		start_dir="$(cd "$clean_dir" && pwd)"
	else
		echo "Error: Directory '$clean_dir' does not exist" >&2
		exit 1
	fi
fi

echo "Searching for Flutter projects in: $start_dir"

# Find all pubspec.yaml files (excluding hidden directories)
find "$start_dir" -type d -name '.*' -prune -o -type f -name 'pubspec.yaml' -print | while read -r pubspec; do
	project_dir=$(dirname "$pubspec")

	# Verify it's a Flutter project (has lib/ directory)
	if [ -d "$project_dir/lib" ]; then
		echo "Cleaning Flutter project: $project_dir"
		(cd "$project_dir" && flutter clean)
	fi
done

echo "Flutter project cleaning complete"
