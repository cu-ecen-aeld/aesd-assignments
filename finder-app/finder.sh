#!/bin/sh

filesdir=$1
searchstr=$2

if [ "$#" -ne 2 ]; then
    echo "Error: Two arguments are required. Use: ./finder.sh <directory> <searchstr"
    exit 1
fi

if [ ! -d "$filesdir" ]; then
    echo "Error: The directory does not exists"
    exit 1
fi

number_of_files=$(find "$filesdir" -type f | wc -l)

number_of_lines=$(grep -ro "$searchstr" "$filesdir" | wc -l)

echo "The number of files are $number_of_files and the number of matching lines are $number_of_lines"
