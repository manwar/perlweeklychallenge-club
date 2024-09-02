#!/usr/bin/env bash 
#
# The Weekly Challenge 284 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
#
# Task 1 - Lucky Integer

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

function lucky_integer() {
    local nums=("$@")
    local lucky_integer=-1
    declare -A local frequencies="($(frequency "${nums[@]}"))"

	for key in ${!frequencies[@]}; do
        if [ ${frequencies[$key]} -eq $key ] && [ $key -gt $lucky_integer ]; then
			lucky_integer=$key
		fi
	done

	echo $lucky_integer
}

examples=('2 2 3 4' '1 2 2 3 3 3' '1 1 1 3')

for e in ${!examples[@]}; do
    li=($(lucky_integer "${examples[$e]}"))
    echo "Input  : nums = (${examples[$e]})"
    echo "Output : $li"
    echo ""
done

