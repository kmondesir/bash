destination=$1
local_user=$2
remote_user='guest'
share='public'

mount=~/mount

osxdocuments=~/Documents
osxdesktop=~/Desktop
osxdownloads=~/Downloads
osxpictures=~/Pictures

win10documents="/users/${remote_user}/documents"
win10desktop="/users/${remote_user}/desktop"
win10downloads="/users/${remote_user}/downloads"
win10pictures="/users/${remote_user}/documents"

if [[ ! -d "${mount}/${local_user}" ]]; then
	echo "Please type the password to your remote system and press ENTER:"
	read password
	mkdir ${mount}/${local_user}
	mount -t smbfs //${remote_user}:${password}@${destination}/${share} ${mount}/${local_user}	
	
	cp -aRv ${osxdocuments}/* ${mount}/${local_user}/${local_user}	
	cp -aRv ${osxdesktop}/* ${mount}/${local_user}/${local_user}
	cp -aRv ${osxdownloads}/* ${mount}/${local_user}/${local_user}
	cp -aRv ${osxpictures}/* ${mount}/${local_user}/${local_user}
		
	umount ${mount}/${local_user}
	sleep 5s
	rm -r ${mount}/${local_user}
	sleep 5s
	exit 0
else
	exit 1
fi

echo "cp ${osxdocuments}/* ${mount}/${win10documents}"
echo "cp ${osxdesktop}/* ${mount}/${win10desktop}"
echo "cp ${osxdownloads}/* ${mount}/${win10downloads}"
echo "cp ${osxpictures}/* ${mount}/${win10pictures}"
