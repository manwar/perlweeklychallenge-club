#!/opt/homebrew/bin/bash

shopt -s extglob

while read input
do    input=${input//+([^[:space:][:alpha:]])}  # Remove all non letters,
                                                # but keep the spaces
      input=${input/#+([[:space:]])}            # Remove leading white space
      input=${input/%+([[:space:]])}            # Remove trailing white space
      input=${input@L}                          # Lower case entire string

      #
      # Upper case the first letter of each word; the ${param^pat}
      # and its friends, only work on matches of a single character.
      # So, we cannot match a letter following a space and upper
      # case the letter. Hence, we split on the string on white
      # space, upper case the first letter of each word, and
      # concatenate the result.
      #
      set $input
      output=""
      for word in $@
      do output=$output${word^}
      done

      output="#${output,}"                      # Lower case the first letters,
                                                # and add a leading '#'

      echo ${output:0:100}                      # Print up to 100 characters
done
