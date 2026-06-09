#!/opt/homebrew/bin/bash

while read line
do   for ((i = 0; i < ${#line} - 1; i ++))
     do  c1=${line:$i:1}               # Grab any two letter substr ("$c1$c2")
         c2=${line:$((i + 1)):1}
         for ((j = 0; j < ${#line} - 1; j ++))
         do  d1=${line:$j:1}           # Compare with all other two letter
             d2=${line:$((j + 1)): 1}  # substrings, reversed ("$d2$d1")
             if   [[ $c1 == $d2 && $c2 == $d1 ]]
             then echo "true"
                  continue 3
             fi
          done
     done
     echo "false"  # No match
done
