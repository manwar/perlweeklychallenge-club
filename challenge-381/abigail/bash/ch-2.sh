#!/opt/homebrew/bin/bash

while read -a numbers
do    ((max_c = 0))
      ((min_c = 0))
      for ((i = 0; i < ${#numbers[@]}; i ++))
      do  if   ((!min_c || ${numbers[i]} < min))
          then ((min   = ${numbers[i]}))
               ((min_c = 0))
          fi
          if   ((!max_c || ${numbers[i]} > max))
          then ((max   = ${numbers[i]}))
               ((max_c = 0))
          fi
          if   ((min == ${numbers[i]}))
          then ((min_c ++))
          fi
          if   ((max == ${numbers[i]}))
          then ((max_c ++))
          fi
      done
      echo $((count = ${#numbers[@]} - min_c - (min == max ? 0 : max_c)))
done
