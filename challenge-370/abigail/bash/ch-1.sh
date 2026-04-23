#!/opt/homebrew/bin/bash

shopt -s extglob

declare -A banned
declare -A ok

while read input
do   #
     # Parse input: lower case all, split on '//'
     #
     input=${input@L}
     paragraph=${input/\/\/*/}
     banned_str=${input/*\/\//}

     #
     # Empty the banned and ok arrays
     #
     banned=()
     ok=()

     #
     # Populate the banned array
     #
     for ban in $banned_str
     do  banned[$ban]=1
     done

     #
     # Replace all sequences of non-letters by a single space
     #
     paragraph=${paragraph//+([^[:alpha:]])/ }

     #
     # For all words in the paragraph, if they aren't banned,
     # tally them in the ok array
     #
     for word in $paragraph
     do  if   [[ ! ${banned[$word]} ]]
         then ok[$word]=$((${ok[$word]:=0} + 1))
         fi
     done

     #
     # Find the most frequently used word
     #
     max="?"
     for word in ${!ok[@]}
     do if   ((${ok[$word]} > ${ok[$max]:=0}))
        then max=$word
        fi
     done

     #
     # Print result
     #
     echo $max
done
