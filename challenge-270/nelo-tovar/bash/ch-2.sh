#!/usr/bin/env bash 
#
# The Weekly Challenge 270 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/
#
# Task 2 : Equalize Array

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

function get_less_than() {
    local number=$1
    shift 1
    local array=("$@")
    local temp=()

    for i in ${array[@]}; do
        if [[ $i < $number ]]; then
            temp+=($i)
        fi
    done

    echo "${temp[@]}"
}

function equalize_array() {
    local x=$1
    local y=$2
    shift 2
    local ints=("$@")
    local max=$(max "${ints[@]}")
    local to_process=($(get_less_than $max "${ints[@]}"))
    local len=${#to_process[@]}
    local cost=0

    while [[ $len > 0 ]]; do
        if [[ $len -eq 1 ]]; then
            ((to_process[0]++))
            ((cost+=$x))
        else
            ((to_process[0]++))
            ((to_process[1]++))
            ((cost+=$y))

        fi
        to_process=($(get_less_than $max "${to_process[@]}")) >&2
        len=${#to_process[@]}

    done

    echo $cost
}

examples_ints=('4 1' '2 3 3 3 5')
examples_x=(3 2)
examples_y=(2 1)

for e in ${!examples_ints[@]}; do
    array=(${examples_ints[$e]})
    x=${examples_x[$e]}
    y=${examples_y[$e]}
    ea=$(equalize_array $x $y "${array[@]}")
    echo "Input  : ints = (${array[@]}), x = $x and y = $y"
    echo -e "Output : $ea\n"
done

