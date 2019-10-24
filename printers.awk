BEGIN { FS=";"; printf "%10s,%10s,%10s,%20s\n", "Title", "Location", "IP", "Path"; OFS="\t\t";
print "-----------------------------------" }
{ printf "%10s %10s %10s %20\n", $1, $2, $3, $4 }
END { print "-----------------------------------";
    print "Total number of rows: " NR }