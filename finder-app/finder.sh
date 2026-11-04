#!/bin/sh
if [ $# -lt 2 ]; then
    echo "Error: Parameters not specified. Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' does not represent a directory on the filesystem."
    exit 1
fi

X=$(find "$filesdir" -type f | wc -l)

Y=$(grep -rn "$searchstr" "$filesdir" 2>/dev/null | wc -l)

echo "The number of files are $X and the number of matching lines are $Y"
exit 0