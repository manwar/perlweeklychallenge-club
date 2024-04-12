#!/usr/bin/env bash 
#
# The Weekly Challenge 264 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
#
# Task 2 : Target Array

function target_array() {
    local source=($1)
    local indices=($2)
    local target=()

    for j in ${!indices[@]}; do
        i=${indices[$j]}
        part1=${target[@]:0:$i}
        part2=${target[@]:$i}

        target=($part1)
        target+=(${source[$j]})
        target+=($part2)
    done

    echo ${target[@]}
}

example_sources=('0 1 2 3 4' '1 2 3 4 0' '1')
example_indices=('0 1 2 2 1' '0 1 2 3 0' '0')

for e in ${!example_sources[@]}; do
    source=${example_sources[$e]}
    indices=${example_indices[$e]}
    ta=$(target_array "$source" "$indices")
    echo "Input  : sources = ($source)"
    echo "         indices = ($indices)"
    echo -e "Output : $ta\n"
done

