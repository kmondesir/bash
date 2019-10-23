export name=$1
export list=$2

<<<<<<< HEAD
function validate_ip()
{
	# https://www.linuxjournal.com/content/validating-ip-address-bash-script
	# https://linuxize.com/post/bash-functions/
	# uses a pattern to match values that fit a IPv4 sequence
	# returns a success or failure exit code
	value=${address}
	pattern=$(~^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$)
	if [[ $value == ${pattern} ]]; then
		oifs=$IFS
		IFS='.'
		ip=($value)
		[[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]d} -le 255 && ${ip[3]} -le 255 ]]
		flag=$?
	fi
	return $flag
}

if [[ validate_ip ]]; then
	if [[ -f ${package} ]]; then 
		# installs a printer based on 4 arguments entered at the terminal
		lpadmin -p ${name} -L ${location} -E -v lpd://${address} -P ${package}"
=======
# https://www.tecmint.com/learn-awk-variables-numeric-expressions-and-assignment-operators/
location="$(awk -v title="$name" `/^title/ {value=$2 print value}` "$list")"
address="$(awk -v title="$name" `/^title/ {value=$3 print value}` "$list")"
package="$(awk -v title="$name" `/^title/ {value=$4 print value}` "$list")"
# https://likegeeks.com/awk-command/
if [[ $name ]]; then
	if [[ -f $list ]]; then
    # The script should be run with the following syntax: install_printers 'photocopier' 'printers.csv'
		echo "lpadmin -p ${name} -L ${location} -E -v lpd://${address} -P ${package}"
>>>>>>> 4bec2d53de7d5489b477b5c5c6cb8ce431724fc8
		exit 0
	else
		echo "list does not exit or not valid"
		exit 1
	fi
else
	echo "Name field is blank"
	exit 1
<<<<<<< HEAD

=======
>>>>>>> 4bec2d53de7d5489b477b5c5c6cb8ce431724fc8
fi