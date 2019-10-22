BEGIN { FS=";"; printf "%15s %12s %50s\n", "Title", "IP", "Path" 
printf "-----------------------------------" }
{ printf "%15s %12s %50\n", $1, $2, $3 }
END { print "-----------------------------------"
    print "Total number of rows: " NR }