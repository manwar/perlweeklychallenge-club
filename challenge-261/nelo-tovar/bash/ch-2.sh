#!/usr/bin/env bash 
#
# The Weekly Challenge 261 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/
#
# Task 2 : Multiply by Two

function in_array() {
    local number=$1
    shift
    local array=("$@")
    local length=${#array[@]}
    local found=0

    for i in ${array[@]}; do
        if [ $number -eq $i ]; then
            found=1
            break
        fi
    done

    echo $found
}

function multiply_by_two() {
    local start=$1
    shift
    local nums=("$@")

    while [[ $(in_array $start ${nums[@]}) -eq 1 ]]; do
        ((start*=2))
    done

    echo $start
}

example0='5 3 6 1 12'
example1='1 2 4 3'
example2='5 6 7'
example_start=(3 1 2)

for e in 0 1 2; do
    var="example$e"
    array=(${!var})
    start=${example_start[$e]}
    mbt=$(multiply_by_two $start "${array[@]}")
    echo "Input  : ints = (${array[@]}) and start = $start"
    echo -e "Output : $mbt\n"
done

