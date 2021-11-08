#!/bin/bash
# The Weekly Challenge - 119 
# Task 1 Swap Nibbles
# Usage: $ chmod +x ch-1.sh
#        $ ./ch-1.sh N

N=$1

if [ $N -gt 255 ] || [ $N -lt 1 ] ;
then 
    echo "Integer within 1 to 255."
    exit ;
fi

A=$(($N/16))
B=$(($N%16))

echo $(($B*16+$A))
