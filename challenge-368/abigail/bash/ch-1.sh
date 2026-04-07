#!/opt/homebrew/bin/bash

while read line digit
do    ((index = -1))  # Index of character to be removed

      #
      # Find the first occurrence of the digit in the string,
      # which is followed by a larger digit. Remember its position.
      #
      for ((i = 0; i < ${#line} - 1; i ++))
      do  ((ch  = ${line:$i:1}))             # Character on index i
          ((nch = ${line:$((i + 1)):1}))     # Character on index i + 1
          if   [[ $ch -eq $digit && $nch -gt $digit ]]
          then ((index = i))
               break
          fi
      done

      # 
      # If not found, find the last occurrence of the digit in the string.
      #
      if   [[ $index -eq -1 ]]
      then for ((i = ${#line} - 1; i >= 0; i --))
           do  if   [[ ${line:$i:1} -eq $digit ]]
               then ((index = i))
                    break
               fi
           done
      fi

      #
      # Print the string, with the offending digit skipped.
      #
      echo ${line:0:$index}${line:$((index + 1))}
done
