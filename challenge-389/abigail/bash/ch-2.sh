#!/opt/homebrew/bin/bash

shopt -s extglob

while read -a numbers
do   pat=""
     for ((index = 1; $index < ${#numbers[@]}; index ++))
     do    left=${numbers[$((index - 1))]}
           right=${numbers[$index]}
           if ((left <  right)); then pat=${pat}0; fi
           if ((left == right)); then pat=${pat}1; fi
           if ((left >  right)); then pat=${pat}2; fi
     done

     ((max = 1))

     ((l1 = 1))
     ((l2 = 0))

     while ((${#pat} > 0))
     do    pat=${pat/#+(1)/}
           l1=${#pat}
           pat=${pat/#?(0)*(20)?(2)/}
           l2=${#pat}
           if   ((l1 - l2 >= max))
           then ((max = l1 - l2 + 1))
           fi
     done
     echo $max
done
