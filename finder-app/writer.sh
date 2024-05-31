#!/bin/sh
newfilename=$1
strtoinsert=$2
if [ $# -ne 2 ]
    then
        echo "need to specify both argument"
        exit 1 
fi
mkdir -p $( dirname $newfilename)
if [ $? -ne 0 ]
    then
        echo "can\'t create file path"
	exit 1
fi
touch $newfilename 
if [ -w $newfilename ]
    then
        if [ $? -ne 0 ] || [ -d $newfilename ]
        then
            echo "can\'t create file $newfilename"
            exit 1
        fi
    echo $strtoinsert > $newfilename
    else
        echo "$newfilename is not writable"
        exit 1
fi
