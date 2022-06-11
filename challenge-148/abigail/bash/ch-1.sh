#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: bash ch-1.sh
#

for ((i = 0; i <= 100; i ++))
do  if [[ !($i =~ ^0$|[1789]|^2.|[35]$) ]]
    then printf "%d " $i
    fi
done
echo
