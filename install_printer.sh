# name=$1
# list=$2
# location=$(awk -f printers.awk $0 ~${name} {print $2} printers.txt)
# address=$(awk -f printers.awk $0 ~${name} {print $3} printers.txt)
# package=$(awk -f printers.awk $0 ~${name} {print $4} printers.txt)
# https://likegeeks.com/awk-command/
# if [[ $name ]]; then
# 	if [[ -f $list ]]; then
# 		echo "lpadmin -p ${name} -L ${location} -E -v lpd://${address} -P ${package}"
# 		exit 0
# 	else
# 		echo "list does not exit"
# 		exit 1
# 	fi
# else
# 	echo "Name field is blank"
# 	exit 1
# fi

printers.txt | awk -f printers.awk