#!/opt/homebrew/bin/bash

while read -a words
do   count=0
     for ((i = 0; i < ${#words[@]} - 1; i ++))
     do   for ((j = $i + 1; j < ${#words[@]}; j ++))
          do  w1=${words[$i]}
              w2=${words[$j]}
              if   ((${#w2} > ${#w1}))
              then w1=${words[$j]}
                   w2=${words[$i]}
              fi
              prefix=${w1:0:${#w2}}
              suffix=${w1: -${#w2}}
              if   [[ $prefix == $w2 && $suffix == $w2 ]]
              then ((count ++))
              fi
          done
     done
     echo $count
done
