#!/usr/bin/env bash 
#
# The Weekly Challenge 276 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
#
# Task 2 - Maximum Frequency

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

function frequency() {
    local array=("$@")
    declare -A local frequency

    for i in ${array[@]}; do
        temp=${frequencyf[$i]}
        ((temp++))
        frequencyf[$i]=$temp
    done

    echo "${frequencyf[@]@K}"
}

function maximum_frecuency() {
    local ints=("$@")
    local amount=0
    declare -A local frequency="($(frequency ${ints[@]}))"
    local max=$(max ${frequency[@]})

    for key in ${ints[@]}; do
        if [[ ${frequency[$key]} -eq $max ]];then
            ((amount++))
        fi
    done

    echo $amount
}

examples=('1 2 2 4 1 5' '1 2 3 4 5')

for e in "${examples[@]}"; do
    array=($e)
    mf=$(maximum_frecuency "${array[@]}")
    echo "Input  : ints = (${array[@]})"
    echo -e "Output : $mf\n"
done

