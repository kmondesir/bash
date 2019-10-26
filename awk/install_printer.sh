#!/bin/bash


export -p name=$1
export -p list=$2
export -p reference=$3
echo $name
echo $list
echo $reference
# https://www.tecmint.com/use-shell-script-variable-in-awk/
location=$(awk -f "$reference" search="$name" column="2" "$list")
address=$(awk -f "$reference" search="$name" column="3" "$list")
package=$(awk -f "$reference" search="$name" column="4" "$list")

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
