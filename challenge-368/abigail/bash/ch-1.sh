#!/opt/homebrew/bin/bash

while read input digit
do    ((index = -1))  # Index of character to be removed

      #
      # Find the first occurrence of the digit in the string,
      # which is followed by a larger digit. Remember its position.
      #
      for ((i = 0; i < ${#input} - 1; i ++))
      do  ((ch  = ${input:$i:1}))             # Character on index i
          ((nch = ${input:$((i + 1)):1}))     # Character on index i + 1
          if   [[ $ch -eq $digit && $nch -gt $digit ]]
          then ((index = i))
               break
          fi
      done

      # 
      # If not found, find the last occurrence of the digit in the string.
      #
      if   [[ $index -eq -1 ]]
      then for ((i = ${#input} - 1; i >= 0; i --))
           do  if   [[ ${input:$i:1} -eq $digit ]]
               then ((index = i))
                    break
               fi
           done
      fi

      #
      # Print the string, with the offending digit skipped.
      #
      echo ${input:0:$index}${input:$((index + 1))}
done
