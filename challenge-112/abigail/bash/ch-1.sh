#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

IFS="/"

while read -a i_parts
do    declare -a o_parts
      j=0
      for ((i = 0; i < ${#i_parts[@]}; i ++))
      do  if [ "X${i_parts[$i]}" == "X" ]       # Skip empty parts
          then continue
          fi
          if [ "X${i_parts[$i]}" == "X." ]      # Skip current directory
          then continue
          fi
          if [ "X${i_parts[$i]}" == "X.." ]     # Back up to parent directory
          then if ((j > 0))
               then ((j --))
               fi
               continue
          fi
          o_parts[$j]=${i_parts[$i]}            # Copy part
          ((j ++))
      done
      if  ((j == 0))
      then echo "/"                             # Root directory
      else for ((k = 0; k < j; k ++))           # Canonical path
           do  printf "/%s" ${o_parts[$k]}
           done
           echo
      fi
done
