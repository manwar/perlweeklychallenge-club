#!/opt/homebrew/bin/bash

while read line
do   ((count_0 = 0))
     ((count_1 = 0))
     for ((i = 0; i < ${#line}; i ++))
     do  char=${line:$i:1}             # Character on position $i
         if [[ $char == "0" ]]
         then ((count_0 ++))
         fi
         if [[ $char == "1" ]]
         then ((count_1 ++))
         fi
     done
     for ((i = 1; i < count_1; i ++))
     do  printf "1"
     done
     for ((i = 0; i < count_0; i ++))
     do  printf "0"
     done
     echo 1
done
