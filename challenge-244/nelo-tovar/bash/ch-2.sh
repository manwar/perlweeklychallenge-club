#!/usr/bin/env bash 
#
# The Weekly Challenge 244 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
#
# Task 2 : Group Hero

function combinations() {
    local -a results=()
    let idx=$1
    shift
    local list=("$@")
    local length=${#list[@]}

    for (( j = 0; j < $length; j++ )); do
            if (( idx % 2 )); then 
                results=("${results[@]}" "${list[$j]}"); 
            fi
            let idx\>\>=1
    done
    echo "${results[@]}"
}

function min() {
    local array=("$@")
    local min=${array[0]}

    for n in ${array[@]}; do
        if [[ n -lt $min ]]; then
            min=$n
        fi
    done

    echo $min
}

function max() {
    local array=("$@")
    local max=${array[0]}

    for n in ${array[@]}; do
        if [[ n -gt $max ]]; then
            max=$n
        fi
    done

    echo $max
}

function group_hero() {
    local nums=("$@")
    local n=${#nums[@]}
    local sum=0

    for (( k = 1; k < 2**n; k++ )); do
        c=($(combinations $k "${array[@]}"))
        min=$(min "${c[@]}")
        max=$(max "${c[@]}")
        ((sum+=($max ** 2) * $min))
    done

    echo $sum
}

example1='2 1 4'

for e in "$example1"; do
    array=($e)
    gh=$(group_hero "${array[@]}")
    echo "Input  : nums = (${array[@]})"
    echo -e "Output : $gh\n"
done

