#!/opt/homebrew/bin/bash

function ord {
    printf "%d" "'$1"
}
function chr {
    printf "\\$(printf %o "$1")"
}

while read -a letters
do   for ((i = 0; i < ${#letters[@]}; i ++))
     do  if   [[ ${letters[$i]} == "?" ]]
         then qi=$i
         fi
         letters[$i]=$(ord ${letters[$i]})
      done
      base=${letters[$((qi <= 2 ? qi + 1 :                    qi - 1))]}
      from=${letters[$((qi <  2 ? qi + 3 : qi == 2 ? qi - 1 : qi - 3))]}
      to=${letters[$((  qi <  2 ? qi + 2 :                    qi - 2))]}
      echo $(chr $((base - from + to)))
done
