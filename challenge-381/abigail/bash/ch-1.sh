#!/opt/homebrew/bin/bash

declare -A matrix
((row_nr = 0))
((r      = 1))

while read -a line
do    ((N = ${#line[@]}))
      for  ((i = 0; i < N; i ++))
      do   ((number = ${line[$i]}))
           if   ((number < 1 || number > N))
           then ((r = 0))
           fi
           matrix[$row_nr,$i]=$number
      done
      ((row_nr ++))
done

declare -A row
declare -A col

for ((i = 0; i < N; i ++))
do  row=()
    col=()
    for  ((j = 0; j < N; j ++))
    do   row[${matrix[$i,$j]}]=1
         col[${matrix[$j,$i]}]=1
    done
    if   ((${#row[@]} != N || ${#col[@]} != N))
    then ((r = 0))
    fi
done

if   ((r == 1))
then echo true
else echo false
fi
