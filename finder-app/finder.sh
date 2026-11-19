#!/bin/sh


if [ "$#" -ne 2 ]
then
	echo "Usage: ./finder.sh filesdir searchstr"
	exit 1
fi
filesdir=$1
searchstr=$2
if ! [ -d "$filesdir" ]
then 
	echo "$filesdir does not represent a directory"
	exit 1
fi

num_files_dir=$(find $filesdir | wc -l)
if [ "$num_files_dir" -eq 1 ]
then
	echo "no files or directories present in $filesdir"
	exit 1
fi
n=$(( $num_files_dir - 1 )) #find returns . in a directories so subtract 1

if [ "$?" -ne 0 ]; then #Evaluate return value of find
	echo "find in $filesdir failed with $?"
	exit 1
fi
match_lines=$(grep -r $searchstr $filesdir -l | wc -l)
if [ "$?" -ne 0 ]; then #Evaluate return value of grep
	echo "grep in $filesdir for $searchstr failed with $?"
	exit 1
fi
echo "The number of files are ${n} and the number of matching lines are ${match_lines}"
