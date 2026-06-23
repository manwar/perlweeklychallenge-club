#!/opt/homebrew/bin/bash

while read line
do    line=$(echo $line | tr a-j 0-9)           # Replace letters with digits
      set $line                                 # Split on whitespace
      if   (("10#$1" + "10#$2" - "10#$3" == 0)) # Force base 10 numbers
      then echo "true"                          # True of first two sum to third
      else echo "false"                         # False otherwise
      fi
done
