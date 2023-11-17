#!/usr/bin/env bash 
#
# The Weekly Challenge 243 - by Nelo Tovar
#
# Task 2 : Floor Sum 
#

function sum_of_floor() {
    local nums=("$@")
    local sum=0

    for i in ${nums[@]}; do
        for j in ${nums[@]}; do
            ((sum+=$(($i/$j))))
        done
    done

    echo $sum
}

example1='2 5 9'
example2='7 7 7 7 7 7 7'

for e in "$example1" "$example2"; do
    array=($e)
    sof=$(sum_of_floor "${array[@]}")
    echo "Input  : nums = (${array[@]})"
    echo -e "Output : $sof\n"
done

