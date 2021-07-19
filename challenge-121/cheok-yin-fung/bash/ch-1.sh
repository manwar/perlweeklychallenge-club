#!/bin/bash                                                                     
# The Weekly Challenge - 121                                                   
# Task 1 Invert Bit                                                           
# Usage: $ chmod +x ch-1.sh                                                     
#        $ ./ch-1.sh n m                                                          

n=$1
m=$2

if [ $n -gt 255 ] || [ $n -lt 0 ] ;
then
    echo "Integer within 0 to 255."
    exit 
fi

t=$n
c=0
declare -a arr

while [ $t -gt 0 ]
do
    c=$(($c+1))
    if [ $c -ne $m ] ;
        then arr+=($(($t%2)))
        else arr+=($(($(($t%2+1))%2)))
    fi
    t=$(($t/2))
done

ans=0

if [ $c -lt $m ];
    then ans=$(($n+2**($m-1)))
    else 
        for (( i = 0 ; i < $c ; i++ )); do
            ans=$(( $ans + $[arr[i]] * 2**i ))
        done
fi

echo $ans
