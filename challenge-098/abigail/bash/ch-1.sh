#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#
# Each line of input consists of a filename and an amount
# of characters to read.
#

#
# Create associative arrays
#
declare -A content
declare -A read

function readN {
    #
    # Read arguments
    #
    filename=$1
    amount=$2

    #
    # First time? Then read in file.
    #
    if   [ "${read[$filename]}" != "1" ]
    then read[$filename]=1
         content[$filename]=$(<$filename)
    fi

    #
    # Leading $amount characters
    #
    r=${content[$filename]:0:$amount}

    #
    # Remove $amount characters
    #
    content[$filename]=${content[$filename]:$amount}

    echo $r
}


#
# Read input, call readN
#
while read filename amount
do    readN $filename $amount
done
