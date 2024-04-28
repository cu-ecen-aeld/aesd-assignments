#!/bin/sh

writefile=$1
writestr=$2


if [ "$#" -ne 2 ]; then
    echo "Error: Two arguments are required. Use: ./wrtier.sh <full path to file> <text string>"
    exit 1
fi


directory_path=$(dirname "$writefile")

mkdir -p "$directory_path"

if [ $? -ne 0 ]; then
    echo "Error: Failed to create directory '$directory_path'"
    exit 1
fi

echo "$writestr" > "$writefile"
if [ $? -ne 0 ]; then
    echo "Error: Failed to write to file '$writefile'"
    exit 1
fi 

