#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

#
# Read in a line from STDIN, split it on whitespace,
# put the result into an array 'words'
#
while read -a words
do
     #
     # Iterate over the words backwards, and print them.
     #
     for  ((i = ${#words[@]} - 1; i >= 0; i --));
     do   printf "%s" ${words[$i]}
          #
          # Print a newline after the final word; otherwise,
          # print a space.
          #
          if    (($i == 0))
          then  printf "\n"
          else  printf " "
          fi
     done
done
