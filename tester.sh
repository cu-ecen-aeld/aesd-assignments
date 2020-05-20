#!/bin/bash
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo

set -e
set -u

NUMFILES=10
WRITESTR=AESD_IS_AWESOME
WRITEDIR=/tmp/aesd-data
# TODO: Store your username in a variable USERNAME, hardcode it, do not use git --user
USERNAME=your-github-name-here

if [ $# -lt 2 ]
then
	echo "Using default value ${WRITESTR} for string to write"
	if [ $# -lt 1 ]
	then
		echo "Using default value ${NUMFILES} for number of files to write"
	else
		NUMFILES=$1
	fi	
else
	NUMFILES=$1
	WRITESTR=$2
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"
mkdir -p "$WRITEDIR"

#The WRITEDIR is in quotes because if the directory path consists of spaces, then variable substitution will consider it as multiple argument.
#The quotes signify that the entire string in WRITEDIR is a single string.
#This issue can also be resolved by using double square brackets i.e [[ ]] instead of using quotes.
if [ -d "$WRITEDIR" ]
then
	echo "$WRITEDIR created"
else
	exit 1
fi

# Please do not modify this line, for compatibility with upcoming assignments
# ----------------------------------------------------
# YOUR CODE BELOW: the example implementation only writes one file
# You need to modify it to write the number of files passed as the NUMFILES parameter
# And customize the written filename with numbers 1-10

#./writer.sh "$WRITEDIR/$USERNAME.txt" "$WRITESTR"

# ----------------------------------------------------
# End of your code modifications.  Please don't modify this line
# For compatibility with upcoming assignments

# Invoke the finder shell script and save the output in OUTPUTSTRING
OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")

set +e
echo ${OUTPUTSTRING} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
	echo "success"
	exit 0
else
	echo "failed: expected  ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
	exit 1
fi
