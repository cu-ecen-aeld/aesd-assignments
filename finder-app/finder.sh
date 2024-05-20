#!/bin/bash
filesdir=$1
searchstr=$2
if [ $# -ne 2 ]
    then
        echo must specify serch dir and tooken 
        exit 1 
fi
if [ -d $1 ]
then
    fileslist=$( ls -1 $filesdir )
    filesCount=$( ls -1 $filesdir | wc -l )
    searchInFilesCount=$( grep -r "$searchstr" $filesdir 2>/dev/null |wc -l )
    echo The number of files are $filesCount and the number of matching lines are $searchInFilesCount
else
    echo $1 not seems to be a directory
    exit 1
fi
