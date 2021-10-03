#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

IFS="/"

function g2j () {
    local Y=$1
    local M=$2
    local D=$3
    J=$(( ((1461 * (Y + 4800  +  (M - 14) / 12))  /   4   +
           (367 * (M - 2 - 12 * ((M - 14) / 12))) /  12   -
           (3 * ((Y + 4900    +  (M - 14) / 12)   / 100)) / 4 + D - 32075) ))
}

function j2g () {
    local J=$1
    local e=$(( 4 * (J + 1401 +
             (((4 * J + 274277) / 146097) * 3) / 4 - 38) + 3 ))
    D=$((  ((5 * ((e % 1461) / 4) + 2) % 153) / 5 + 1 ))
    M=$(( (((5 * ((e % 1461) / 4) + 2) / 153 + 2) % 12) + 1 ))
    Y=$((         (e / 1461) - 4716 + (12 + 2 - M) / 12 ))
}

g2j 2021 9 22; julian_today=$J

while read y m d
do   g2j ${y/#0/} ${m/#0/} ${d/#0/}; julian_then=$J
     j2g $(( 2 * julian_then - julian_today ))
     printf "%04d/%02d/%02d, " $Y $M $D
     j2g $(( 2 * julian_today - julian_then ))
     printf "%04d/%02d/%02d\n" $Y $M $D
done
