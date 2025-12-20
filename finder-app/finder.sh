#!/bin/bash

echo $1
echo $2

if [ $# -ne 2 ]
then
	echo "invalid number of arguments"
	exit 1
fi

if [ ! -d $1 ]
then
	echo "filesdir not found"
	exit 1
fi

X=$(find "$1" -type f | wc -l)
Y=$(grep -r "$2" "$1" | wc -l)

echo "The number of files are $X and the number of matching lines are $Y "

exit 0