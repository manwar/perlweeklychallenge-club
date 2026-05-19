#!/opt/homebrew/bin/bash

while read -a list
do   n=${list[0]}

     #
     # Special case if n exceeds the size of the list
     #
     if   [[ $n -ge ${#list[@]} ]]
     then echo "-1;"
          continue
     fi

     #
     # Calculate the number of elements per set,
     # and how many sets have one more element
     #
     per_set=$(( (${#list[@]} - 1) / $n))
     overflow=$(( ${#list[@]} - 1 - n * per_set))

     ptr=1
     for ((i = 1; i <= n; i ++))
     do  #
         # Calculate the size of the current set
         #
         set_size=$per_set
         if   [[ $i -le $overflow ]]
         then ((set_size ++))
         fi

         #
         # Print a set
         #
         for ((j = 1; j <= set_size; j ++))
         do  echo -n ${list[$ptr]} 
             if [[ $j -eq $set_size ]]
             then echo -n "; "   # ; separates sets
             else echo -n " "
             fi
             ((ptr ++))
         done
     done
     echo
done
