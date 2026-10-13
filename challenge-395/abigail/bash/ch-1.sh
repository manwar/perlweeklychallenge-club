#!/opt/homebrew/bin/bash

while read line
do    set ${line//[^-0-9]/ }
      ((r = $1 * $3 - $2 * $4))
      ((i = $1 * $4 + $2 * $3))
      if   ((i < 0)) 
      then ft="%d+(%d)i\n"
      else ft="%d+%di\n"
      fi
      printf $ft $r $i
done
