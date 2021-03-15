#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

#
# Recursively count matches:
#   - If either the string or the pattern is empty, there are no matches.
#   - Else, + count the matches if we don't match at the first character
#             if the string.
#           + if the first character of the string equals the first
#             character of the pattern:
#             o  add 1 if the pattern is just one character long
#             o  else, add the number of matches starting from the
#                then next character in the string, and the next
#                character in the pattern.
#

#
# Note that we do not have lexical variables in bash, so we're
# using a global count variable.
#
function matches () {
    # 
    # $1: string
    # $2: pattern
    #
    if   ((${#1} && ${#2}))
    then matches "${1:1}" "$2"
         if   [ "${1:0:1}" == "${2:0:1}" ]
         then if   ((${#2} == 1))
              then ((count ++))
              else matches "${1:1}" "${2:1}"
              fi
         fi
    fi
}

while read string pattern
do    count=0
      matches $string $pattern
      echo $count
done
