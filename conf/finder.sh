#!/bin/sh
# Finder script for assignment 1 
# Author: Steven Sharp

#first argument is a path to a directory on the filesystem, referred to below as filesdir;
# the second argument is a text string which will be searched within these files, referred to below as searchstr


#check for missing par
echo "test find"
if [ $# -lt 2 ];then
	echo "failed: expected 2 parameters"
	exit 1
fi

filesdir=$1
searchstr=$2
#echo  "${filesdir} "
if [ -d "${filesdir}" ];then
    echo "${filesdir} exists"
else
	echo "failed: no dir"
	exit 1
fi

# get number of files in dir and sub


#cd $filesdir
echo pwd is $(pwd)
#find "./${filesdir}" -maxdepth 2 -mindepth 2 -type f -printf "%h\0" | uniq -zc | "${X}"
#grep -irm 1 ${searchstr} . | wc -l 
X=$(grep -l -r -i "${searchstr}" "${filesdir}" | wc -l)
echo X is "$X"
#for dir in $(find $filesdir -type d); do
#    echo "${dir}: $(find ${dir} -maxdepth 1 -type f | wc -l)"
#done

Y=$(grep -ir "${searchstr}" "${filesdir}" | wc -l)
#$(grep -ir ${searchstr} . | wc -l)

echo "The number of files are $X and the number of matching lines are $Y " 