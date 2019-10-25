BEGIN { FS=";" }
$0 ~ search { if(column == "2") {print $2} else if(column == "3") {print $3} else {print $4} }