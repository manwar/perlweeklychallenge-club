#!/opt/homebrew/bin/bash

while read line
do    ((max = -1))
      ((sec = -1))
      for ((i = 0; i < ${#line}; i ++))
      do  ch=${line:$i:1}
          if   [[ $ch =~ [0-9] ]]
          then if   [[ $max -lt $ch ]]
               then sec=$max
                    max=$ch
               else if   [[ $max -gt $ch && $ch -gt $sec ]]
                    then sec=$ch
                    fi
               fi
          fi
      done
      echo $sec
done
