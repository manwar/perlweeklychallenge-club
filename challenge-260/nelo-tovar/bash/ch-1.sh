#!/usr/bin/env bash 
#
# The Weekly Challenge 260 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
#
# Task 1 : Unique Occurrences

function unique_occurrences() {
    local nums=("$@")
    local length=${#nums[@]}
    declare -A counter

#    for (( i = 0; i < $length; i++ )); do
#        count=0
#        for (( j = 0 ; j < $length; j++ )); do
#            if [[ ${nums[$j]} -lt ${nums[$i]} ]]; then
#                ((count++))
#            fi
#        done
#        smallers+=($count)
#    done

    for i in ${nums[@]}; do
        counter[$i]=$((${counter[$i]} + 1))
    done

    frequencies=(${counter[@]})
    length=${#frequencies[@]}
    for (( i = 0; i < $length - 1; i++ )); do
        for (( j = i + 1; j < $length; j++ )); do
            if [[ ${frequencies[$i]} -eq ${frequencies[$j]} ]]; then
                echo 0
                return
            fi
        done
    done
    echo 1
}

example1='1 2 2 1 1 3'
example2=' 1 2 3'
example3='-2 0 1 -2 1 1 0 1 -2 9'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    uo=$(unique_occurrences "${array[@]}")
    echo "Input  : ints = (${array[@]})"
    echo "Output : $uo"
    echo ""
done

