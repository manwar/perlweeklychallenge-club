#!/opt/homebrew/bin/bash

IFS=";"

while read line
do    line=${line// }   # Remove spaces
      line=${line//.}   # Remove dots
      set $line         # Split on ;
      if [[ $1 == $2 ]] # Equal?
      then echo true
      else echo false
      fi
done
