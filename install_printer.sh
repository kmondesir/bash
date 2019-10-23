export name=$1
export list=$2

# https://www.tecmint.com/learn-awk-variables-numeric-expressions-and-assignment-operators/
location="$(awk -v title="$name" `/^title/ {value=$2 print value}` "$list")"
address="$(awk -v title="$name" `/^title/ {value=$3 print value}` "$list")"
package="$(awk -v title="$name" `/^title/ {value=$4 print value}` "$list")"
# https://likegeeks.com/awk-command/
if [[ $name ]]; then
	if [[ -f $list ]]; then
    # The script should be run with the following syntax: install_printers 'photocopier' 'printers.csv'
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

printers.txt | awk -f printers.awk