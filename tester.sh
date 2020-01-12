#!/bin/bash
# Tester script for assignment 1.
# Author: Siddhant Jajoo

set -e
set -u

NUMFILES=10
WRITESTR=ECEN_5013_IS_AWESOME
WRITEDIR=/tmp/ecen5013
OUTPUTFILE=assignments/assignment1/assignment1-result.txt


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

#./writer.sh "$WRITEDIR/$WRITESTR" "$WRITESTR"

# ----------------------------------------------------
# End of your code modifications.  Please don't modify this line
# For compatibility with upcoming assignments

mkdir -p `dirname ${OUTPUTFILE}`

./finder.sh "$WRITEDIR" "$WRITESTR" > "${OUTPUTFILE}"

set +e
grep "${MATCHSTR}" ${OUTPUTFILE}
if [ $? -eq 0 ]; then
	echo "success"
	exit 0
else
	echo "failed: expected  ${MATCHSTR} in ${OUTPUTFILE} but instead found"
	cat ${OUTPUTFILE}
	exit 1
fi
