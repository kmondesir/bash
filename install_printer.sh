name=$1
location=$2
address=$3
package=$4

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
		exit 0
	else

		echo "${package} is not a valid file"
		exit 1
	fi
else
	echo "Your ip address is not valid"
	exit 1

fi