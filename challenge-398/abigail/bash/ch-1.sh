#!/opt/homebrew/bin/bash

while read -a numbers
do    ((sum   = 0))
      ((count = 0))
      for number in ${numbers[@]}
      do  if   ((number % 6 == 0))
          then ((sum += number))
               ((count ++))
          fi
      done
      if   ((sum == 0))
      then ((res = 0))
      else ((res = sum / count))
           if   ((2 * (res % count) >= res))
           then ((res ++))
           fi
      fi
      echo $res
done
