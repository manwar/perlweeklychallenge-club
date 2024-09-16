#!/usr/bin/env bash 
#
# The Weekly Challenge 284 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
#
# Task 2 - Relative Sort

function frequency() {
    local array=("$@")
    declare -A local frequency

    for i in ${array[@]}; do
        temp=${frequency[$i]}
        ((temp++))
        frequency[$i]=$temp
    done

    echo "${frequency[@]@K}"
}

function relative_sort() {
    local list1=("$1")
    local list2=("$2")
    declare -A local frequencies="($(frequency "${list1[@]}"))"
    local sorted=()

    for n in ${list2[@]}; do
        if [[ -n "${frequencies[$n]}" ]]; then
            for i in $(seq 1 ${frequencies[$n]}); do
                sorted+=($n)
            done
            unset frequencies[$n]
        fi
    done

    IFS=$'\n' r=($(sort -n <<<"${!frequencies[*]}"))

    for n in ${r[@]}; do
        for i in $(seq 1 ${frequencies[$n]}); do
            sorted+=($n)
        done
    done

    echo ${sorted[@]}
}

examples1=('2 3 9 3 1 4 6 7 2 8 5' '3 3 4 6 2 4 2 1 3' '3 0 5 0 2 1 4 1 1')
examples2=('2 1 4 3 5 6' '1 3 2' '1 0 3 2' )

for e in "${!examples1[@]}"; do
    rs=$(relative_sort "${examples1[$e]}" "${examples2[$e]}")
    echo "Input  : list1 = (${examples1[$e]})"
    echo "         list2 = (${examples2[$e]})"
    echo -e "Output : ${rs[@]}\n"
done

