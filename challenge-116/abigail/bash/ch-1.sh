#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

out=""

function make_sequence () {
    local string=$1
    local start=$2
    if   [[ "$string" = "$start" ]]
    then out=$start
         return
    fi

    if   [[ $string =~ ^$start ]]
    then local tail=${string:${#start}}
         make_sequence $tail $((start + 1))
         if   [[ $out =~ ^. ]]
         then out=$start,$out
              return
         fi
         make_sequence $tail $((start - 1))
         if   [[ $out =~ ^. ]]
         then out=$start,$out
              return
         fi
    fi
    out=""
    return
}


while read string
do    for ((i = 1; i <= ${#string}; i ++))
      do  start=${string:0:$i}
          make_sequence $string $start
          if [[ $out =~ ^. ]]
          then echo $out
               break
          fi
      done
done
