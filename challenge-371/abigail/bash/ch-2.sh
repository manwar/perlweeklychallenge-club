#!/opt/homebrew/bin/bash

while read -a numbers
do    #
      # Iterate over all the possible mask, except all 0s and all 1s.
      #
      for ((mask = 0; mask < 2 ** ${#numbers[@]} - 1; mask ++))
      do  sum=0
          set=()
          for ((index = 0; index < ${#numbers[@]}; index ++))
          do  #
              # If the position of the number is in the mask, add the
              # difference of the number and its position to the sum,
              # and add the number to the current set.
              #
              if (($mask & (1 << $index)))
              then ((sum += ${numbers[$index]} - $index - 1))
                   set+=(${numbers[$index]})
              fi
          done
          #
          # If the sum is 0, and the set contains more than one number,
          # it's time to print the set, followed by a semi-colon.
          #
          if [[ $sum -eq 0 && ${#set[@]} -gt 1 ]]
          then echo -n "${set[@]}; "
          fi
      done
      #
      # Print a newline
      #
      echo
done
