#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

function can_split () {
    local target=$1
    local number=$2

    if ((target > number))
    then can_split=0; return
    fi
    if ((target < 0))
    then can_split=0; return
    fi
    if ((target == number))
    then can_split=1; return
    fi

    local pow_10=10

    while ((pow_10 <= number))
    do can_split $((target - (number % pow_10))) $((number / pow_10))
       if ((can_split == 1))
       then return
       fi
       ((pow_10 *= 10))
    done

    can_split=0
}


while read num
do    sqrt=$(echo "sqrt($num)" | bc)
      if ((num > 1))
      then can_split $sqrt $num
           if ((can_split == 1))
           then echo 1
           else echo 0
           fi
      else echo 0
      fi
done
