#!/bin/sh
# writer script for assignment 1 
# Author: Steven Sharp

#check for missing par
if [ $# -lt 2 ]; then
	echo "failed: expected 2 parameters"
	exit 1
fi

writefile=$1
writestr=$2

#if[ -f $writefile];then
#echo $writefile exists
#else
#	echo "failed: no dir"
#	exit 1
#fi
mkdir -p -- "$(dirname -- $writefile)" && touch -- $writefile
printf "$writestr\n" > $writefile