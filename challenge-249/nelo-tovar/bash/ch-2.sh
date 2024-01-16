#!/usr/bin/env bash 
#
# The Weekly Challenge 249 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
#
# Task 2 : DI String Match

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

function di_string_match() {
    local s=$@
    local length=${#s}
    local data=$(seq 0 $length)

    local R=1000
    local C_RANGE=$(($length + 1))
    for C in $C_RANGE; do
        for I in $(seq 1 $R); do
            ok=1
            perm="$(for X in "${data[@]}"; do echo "$X"; done | shuf -n $C | paste -s -d' ' | tr -d ' ')"

            for (( i = 0; i < $length; i++ )); do
                char=${s:$i:1}
                p1=${perm:$i:1}
                p2=${perm:$i+1:1}

                if [[ $char == 'I' && "$p1" -ge "$p2" ]]; then 
                    ok=0
                    break
                fi
                if [[ $char == 'D' && "$p1" -le "$p2" ]]; then
                    ok=0
                    break
                fi
            done
            if [[ $ok -eq 1 ]]; then
                echo $perm
                return 0
            fi
        done
    done
}

example1='IDID'
example2='III'
example3='DDI'

for e in "$example1" "$example2" "$example3"; do
    array=($e)
    dsm=$(di_string_match "$e")
    #di_string_match $e
    echo "Input  : @str = $e"
    echo -e "Output : $dsm\n"
done

