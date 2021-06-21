#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

function dec2bin () {
    dec=$1
    bin=""
    while ((dec > 0))
    do    bin=$((dec % 2))$bin
          ((dec /= 2))
    done
}

while read dec
do    dec2bin $dec
      for ((i = 0; i < ${#bin} / 2; i ++))
      do  if   [ "${bin:$i:1}" = "${bin:$((${#bin} - i - 1)):1}" ]
          then continue
          fi
          echo 0
          continue 2
      done
      echo 1
done
