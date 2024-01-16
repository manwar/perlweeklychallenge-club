#!/usr/bin/env bash 
#
# The Weekly Challenge 246 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
#
# Task 2 : Linear Recurrence of Second Order 

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

function is_lrso() {
    local a=("$@")
    local length=${#a[@]}
    local min=$(min "${a[@]}")
    local max=$(max "${a[@]}")
    local b=$(($length-2)) 

    for (( p = $min; p < $max; p++ )); do
        for (( q = $min; q < $max; q++ )); do
            count=0

            for (( n = 2; n < $length; n++ )); do
                value=$(($p * ${a[$n-2]} + $q * ${a[$n-1]}))

                if [[ ${a[$n]} -eq $value ]]; then
                    ((count++))
                 fi
            done

            if [[ $count -eq $b ]] ; then
                return 1
            fi
        done
    done

    return 0
}

example1='1 1 2 3 5'
example2='4 2 4 5 7'
example3='4 1 2 -3 8'

for e in "$example1" "$example2" "$example3"; do
#for e in "$example2"; do
    array=($e)
    echo "Input  : a = (${array[@]})"
    echo -n "Output : "
    is_lrso "${array[@]}"
    if [[ $? -eq 1 ]]; then
        echo -e "True\n"
    else
        echo -e "False\n"
    fi
done

