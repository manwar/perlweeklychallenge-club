#!/bin/bash
# The Weekly Challenge - 120
# Task 1 Swap Odd/Even Bits
# Usage: $ chmod +x ch-1.sh
#        $ ./ch-1.sh N

N=$1

if [ $N -gt 255 ] || [ $N -lt 1 ] ;
then 
    echo "Integer within 1 to 255."
    exit ;
fi

x=$N

qp () {
    A=$(($1/2));
    B=$(($1%2));
    echo $(($B*2+$A))
}

while [ $x -ne 0 ]
do
    arr+=($(qp $x%4))
    x=$(($x/4))
done

ANS=0

for ((i=$((${#arr[@]}-1)); i>=0; i=$i-1))
do
    ANS=$(($ANS*4+$[arr[$i]]))
done

echo $ANS
