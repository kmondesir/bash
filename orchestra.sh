


# preprocessing 
mkdir ~/tmp
mkdir ~/mnt
temp=~/tmp
mount=~/mnt
install=//network_share

cp $install/*.sh ~/tmp
chmod u+x $temp/*.sh

# processing

for file in $install
  do
    source file
  done

# post processing
rm -f -d $temp