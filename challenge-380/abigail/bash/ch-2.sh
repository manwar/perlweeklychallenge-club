#!/opt/homebrew/bin/bash

function ord { 
    printf "%d" "'$1"
}

while read line
do    ((sum = 0))
      for ((i = 0; i < ${#line}; i ++))
      do  ((sum += (i + 1) * ($(ord "z") - $(ord ${line:$i:1}) + 1)))
      done
      echo $sum
done
