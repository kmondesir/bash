
#!/bin/bash

export name=$1
export list="./printers"
location=awk /^"$name"/ { print $2 } $(echo $list) 
address=awk /^"$name"/  { print $3 } $("$list") 
package=awk /^"$name"/ { print $4 } $("$list") 
# https://likegeeks.com/awk-command/
# http://www.theunixschool.com/2012/05/awk-match-pattern-in-file-in-linux.html
if [[ $name ]]; then
	if [[ -f $list ]]; then
		echo "lpadmin -p ${name} -L ${location} -E -v lpd://${address} -P ${package}"
		exit 0
	else
		echo "list does not exit"
		exit 1
	fi
else
	echo "Name field is blank"
	exit 1
fi