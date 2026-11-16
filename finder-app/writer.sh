#!/bin/sh

# Check if both arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Check if parameters are empty strings
if [ -z "$writefile" ] || [ -z "$writestr" ]; then
    echo "Error: Parameters cannot be empty."
    exit 1
fi

# Extract the directory path from writefile
dirpath=$(dirname "$writefile")

# Create the directory path if it doesn't exist
if [ ! -d "$dirpath" ]; then
    mkdir -p "$dirpath"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create directory path '$dirpath'."
        exit 1
    fi
fi

# Write the text string to the file, overwriting if it already exists
echo "$writestr" > "$writefile"

# Check if the file was created/written successfully
if [ $? -ne 0 ]; then
    echo "Error: Could not create or write to file '$writefile'."
    exit 1
fi