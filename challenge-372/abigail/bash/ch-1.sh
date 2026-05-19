#!/opt/homebrew/bin/bash

while read line
do    line=${line//\"}                        # Remove quotes
      ((spaces = 0))
      for ((i = 0; i < ${#line}; i ++))       # Count spaces
      do  if   [[ ${line:$i:1} == " " ]]
          then ((spaces ++))
          fi
      done

      set $line                               # Split into words
      ((gaps    = $# - 1))                    # Nr of gaps between words
      ((per_gap = gaps ? spaces / gaps : 0))  # Calculate amount
      ((end     = spaces - per_gap * gaps))   #   of spaces needed

      ((word_c  = 0))                         # Count words
      echo -n '"'                             # Print quote
      for word in $*                          # Iterate over the words
      do echo -n $word                        # Print word
         ((word_c ++))                        # Increment word count
         for ((i = 0; i < (word_c == $# ? end : per_gap); i ++))
         do  echo -n " "                      # Print gap, space by space
         done
      done
      echo '"'                                # Print quote
done
