# create a script
# This script creates a new bash script, sets permissions and more

if [[ ! $1 ]]; then
	echo "Missing an argument"
	exit 1
fi

scriptname="$1"
bindir="${HOME}/bin"
filename="${bindir}/${scriptname}"

if [[ -e $filename ]]; then 
	echo "File ${filename} already exists"
	exit 1
if

if type 

if [[ ! -d $bindir= ]]; then
	if mkdir "$bindir"; then
		echo "created ${bindir}"
	else
		echo "Could not create ${binddir}"
		exit 1
	fi
fi

echo '#!/bin/bash' > "$filename"
