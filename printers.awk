BEGIN { FS=";"; printf "%15s %15s %12s %50s\n", "Title", "Location", "IP", "Path"; OFS="\t\t";
print "-----------------------------------" }
{ printf "%15s %15s %12s %50\n", $1, $2, $3, $4 }
END { print "-----------------------------------";
    print "Total number of rows: " NR }