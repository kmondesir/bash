#!/bin/bash

export -p name=$1
export -p list=$2
echo $name
echo $list
location=`echo $list | awk -v t=$(echo $name) /^t/{print $2}`
address=$(awk /^$name/ $list )
package=$(awk /^$name/ $list )
# https://likegeeks.com/awk-command/
# http://www.theunixschool.com/2012/05/awk-match-pattern-in-file-in-linux.html
if [[ $name ]]; then
	if [[ -f $list ]]; then
		echo "lpadmin -p $name -L $location -E -v lpd://$address -P $package"
		exit 0
	else
		echo "list does not exit"
		exit 1
	fi
else
	echo "Name field is blank"
	exit 1
fi
