#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

function next_number () {
     [[ 0$1 =~ ^(.*)([012])(3*)$ ]]
     next_num=${BASH_REMATCH[1]}$((BASH_REMATCH[2] + 1))${BASH_REMATCH[3]//3/1}
     next_num=${next_num//11/12}
     next_num=${next_num/0/}
}


while read num
do    number="0"
      for ((i = 0; i < num; i ++))
      do  next_number $number
          number=$next_num
      done
      echo $number
done
