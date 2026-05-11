#!/opt/homebrew/bin/bash

while read line
do    ((max = -1))  # Track max difference
      for ((f = 0; f < ${#line}; f ++))             # For each character, ...
      do  for ((l = ${#line} - 1; l > f; l --))     # find matching character
          do  if [[ ${line:$f:1} == ${line:$l:1} ]] # from the end
              then if ((l - f - 1 > $max))          # If larger distance,
                   then ((max = l - f - 1))         # remember it
                   fi
                   break
              fi
          done
      done
      echo $max
done
