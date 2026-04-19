#!/opt/homebrew/bin/bash

while read str size filler
do    #
      # Add $size - 1 filler characters to the string
      #
      for ((i = 1; i < $size; i ++))
      do  str=$str$filler
      done

      #
      # While the string has a length of at least $size, remove
      # the $size characters from the string, and add them to
      # the out array
      #
      out=()
      while ((${#str} >= $size))
      do    out+=(${str:0:$size})
            str=${str:$size}
      done

      #
      # Print the results.
      #
      echo "${out[@]}"
done
