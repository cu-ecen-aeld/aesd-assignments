#!/bin/sh

# Check if both arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

# Assign arguments to variables
writefile=$1
writestr=$2

# Extract the directory path from the file path
writedir=$(dirname "$writefile")

# Create the directory path if it doesn't exist
mkdir -p "$writedir"
if [ $? -ne 0 ]; then
    echo "Error: Could not create directory $writedir"
    exit 1
fi

# Write the string to the file, overwriting any existing file
echo "$writestr" > "$writefile"
if [ $? -ne 0 ]; then
    echo "Error: Could not write to file $writefile"
    exit 1
fi

echo "File $writefile created with content: $writestr"
exit 0
