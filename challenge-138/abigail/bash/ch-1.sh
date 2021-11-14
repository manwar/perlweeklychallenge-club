#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

SUNDAY=0
MONDAY=1
TUESDAY=2
WEDNESDAY=3
THURSDAY=4
FRIDAY=5
SATURDAY=6

LOOKUP=(261 260 260 261 261 261 261 262 261 260 261 262 262 262)
DDVALS=($TUESDAY $SUNDAY $FRIDAY $WEDNESDAY)

function doomsday () {
    local year=$1
    local anchor=${DDVALS[$(((year / 100) % 4))]}
    local y=$((year % 100))
    doomsday=$((((y / 12) + (y % 12) + ((y % 12) / 4) + anchor) % 7))
}

function is_leap () {
    local year=$1
    is_leap=$(((year % 400 == 0) ||
               (year %   4 == 0) && (year % 100 != 0) ? 1 : 0))
}

while read year
do   doomsday $year
     is_leap $year 
     echo ${LOOKUP[$((7 * $is_leap + $doomsday))]}
done
