#!/usr/bin/bash

# Usage:
# $ bash ch-1.bash 100
# 13015
#
# N. B. Try with smaller arguments, as computations
# for the input number of 100 can take a while (~ a minute).

gcd() {
    a=$1;
    b=$2;
    while [ $b -ne 0 ]; do
        t=$b
        b=`expr $a % $b`
        a=$t
    done

    gcd=$a
}

n=${1:-3} # default is 3

s=0
x=1
while [ $x -le $n ]; do
    next=`expr $x + 1`;
    y=$next;
    while [ $y -le $n ]; do
        y=`expr $y + 1`;
        gcd $x $y;
        s=`expr $s + $gcd`;      
    done 
    x=$next;
done

echo $s
