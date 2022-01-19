#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -A palindromes

function is_palindrome () {
    local string=$1
    if ((${#string} < 2))
    then
        is_palindrome=1
        return
    fi
    local f=${string:0:1}
    local s=${string: -1:1}
    if [ $f != $s ]
    then is_palindrome=0
         return
    fi
    is_palindrome ${string:1:$((${#string} - 2))}
}



while read line
do palindromes=()
   for ((i = 0; i < ${#line}; i ++))
   do  for ((j = i; j < ${#line}; j ++))
       do  sub=${line:$i:$((j-i+1))}
           is_palindrome $sub
           if (($is_palindrome == 1))
           then palindromes[$sub]=1
           fi
       done
   done
   first=1
   for p in "${!palindromes[@]}"
   do if   ((first == 1))
      then ((first ++))
      else printf " "
      fi
      printf %s $p
   done
   echo
done
