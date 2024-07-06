#!/usr/bin/env bash 
#
# The Weekly Challenge 276 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
#
# Task 1 - Complete Day

function complete_day() {
    local hours=("$@")
    local length=${#hours[@]}
    local amount=0

    for (( i = 0; i < $length - 1; i++ )); do
        for (( j = $i + 1 ; j < $length; j++ )); do
            ((value=(${hours[$i]} + ${hours[$j]}) % 24))
            if [[ $value -eq 0 ]]; then
                ((amount++))
            fi
        done
    done

    echo $amount
}

examples=('12 12 30 24 24' '72 48 24 5' '12 18 24')

for e in "${examples[@]}"; do
    array=($e)
    cd=($(complete_day "${array[@]}"))
    echo "Input  : hours = (${array[@]})"
    echo "Output : $cd"
    echo ""
done

