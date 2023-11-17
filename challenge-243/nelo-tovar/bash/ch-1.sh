#!/usr/bin/env bash 
#
# The Weekly Challenge 243 - By Nelo Tovar
#
# Task 1 : Reverse Pairs

function get_reverse_pairs() {
    local nums=("$@")
    local length=${#nums[@]}
    local pairs=()

    for (( i = 0; i < $(($length - 1)); i++ )); do
        for (( j = $(($i + 1)) ; j < $length; j++ )); do
            if [[ ${nums[$i]} -gt $((2 * ${nums[$j]})) ]]; then
                pairs+=("($i,$j)")
            fi
        done
    done

    echo ${pairs[@]} 
}

example1='1 3 2 3 1'
example2='2 4 3 5 1'

for e in "$example1" "$example2"; do
    array=($e)
    pairs=($(get_reverse_pairs "${array[@]}"))
    echo "Input  : nums = (${array[@]})"
    echo "Output : ${#pairs[@]}"
    echo -e "Pairs  : ${pairs[@]}\n"
done

