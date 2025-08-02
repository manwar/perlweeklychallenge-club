#!/usr/bin/env bash 
#
# The Weekly Challenge 277 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
#
# Task 2 - Strong Pair

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

function uniq() {
    local array=("$@")
    declare -A local temp
    local unique=()

    for n in ${array[@]}; do
        ((temp[$n]++))
    done

    for i in ${!array[@]}; do
        key=${array[$i]}
        if [ -n "${temp[$key]}" ]; then
            unique+=($key)
            unset temp[$key]
        fi
    done

    echo ${unique[@]}
}

function strong_pair() {
    local elements=("$@")
    local ints=($(uniq ${elements[@]}))
    local length=${#ints[@]}
    local count=0


    for (( i = 0; i < $length - 1; i++ )); do
        for (( j = $i + 1; j < $length; j++ )); do
            ((diff=${ints[$i]} - ${ints[$j]}))
            diff=${diff#-}

            t[0]=${ints[$i]}
            t[1]=${ints[$j]}
            min=$(min "${t[@]}")

            if [ $diff -gt 0 ] && [ $diff -lt $min ]; then
                ((count++))
            fi
        done
    done

    echo $count
}

examples=('1 2 3 4 5' '5 7 1 7')

for e in "${examples[@]}"; do
    array=($e)
    sp=$(strong_pair "${array[@]}")
    echo "Input  : ints = (${array[@]})"
    echo -e "Output : $sp\n"
done

