#!/bin/sh

# Check if both arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check if parameters are empty strings
if [ -z "$filesdir" ] || [ -z "$searchstr" ]; then
    echo "Error: Parameters cannot be empty."
    exit 1
fi

# Check if filesdir represents a directory on the filesystem
if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' does not represent a valid directory on the filesystem."
    exit 1
fi

# Count the number of files in the directory and all subdirectories
X=$(find "$filesdir" -type f | wc -l)

# Count the number of matching lines containing searchstr across the files
# Using 2>/dev/null to suppress permission denied or similar warnings
Y=$(grep -r "$searchstr" "$filesdir" 2>/dev/null | wc -l)

# Print the final result
echo "The number of files are $X and the number of matching lines are $Y"