#!/bin/bash

if [ $# -ne 2 ]
then
echo "invalid number of arguments"
exit 1
fi

wrtdir=$( dirname $1 )

mkdir -p 777 $wrtdir

echo $2 > $1

if [ $? -ne 0 ]
then
echo "write operation failed with status $?"
exit 1
fi
