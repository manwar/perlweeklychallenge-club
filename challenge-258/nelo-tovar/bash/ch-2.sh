#!/usr/bin/env bash 
#
# The Weekly Challenge 258 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
#
# Task 2 : Sum of Values

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

function sum_of_values() {
    local k=$1
    shift 
    local ints=("$@")
    local length=${#ints[@]}
    local sum=0

    for (( i = 0; i < $length; i++ )); do
        bits=$(bc <<< "obase=2;$i")
        one_bits=${bits//0}
        if [[ ${#one_bits} -eq $k ]]; then
            ((sum+=${ints[$i]}))
        fi
    done

    echo $sum
}

example1=('2 5 9 11 3' '2 5 9 11 3' '2 5 9 11 3')
examples_k=(1 2 0)

for (( e = 0; e < ${#examples_k[@]}; e++ )); do
    array=(${example1[$e]})
    k=${examples_k[$e]}
    sov=$(sum_of_values $k "${array[@]}")
    echo "Input  : nums = (${array[@]}), k = $k"
    echo -e "Output : $sov\n"
done

