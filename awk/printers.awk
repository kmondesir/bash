BEGIN { FS=";" }
  $0 ~ search 
  { if(column == "2") 
    # prints the location column
    {print $2} 
  else if(column == "3") 
    # prints the ip address column
    {print $3} 
  else 
    # prints the file column
    {print $4} 
  }