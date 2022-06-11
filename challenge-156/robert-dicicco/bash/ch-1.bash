#!usr/bin/env bash

# AUTHOR: Robert DiCicco
# DATE: 16-MAR-2022
# Challenge 156 Pernicious Numbers  ( Bash )

Primes=' 2 3 5 7 11 13 17 19 23 29 '
Cnt=0
Num=1

until [[ $Cnt -eq 10 ]]
do
        BinNum=`echo "obase=2;$Num" | bc`
        res="${BinNum//[^1]}"
        rescnt=${#res}

        if grep -q " $rescnt " <<< "$Primes"; then
                echo -n "$Num "
                ((Cnt=Cnt+1))
        fi

        ((Num=Num+1))
done

echo " "
