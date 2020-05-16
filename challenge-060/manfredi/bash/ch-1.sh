#!/bin/bash
set -e

declare -a cols=($(echo {A..Z} {A..Z}{A..Z} {A..Z}{A..Z}{A..Z}))
declare -a nums=( $(seq 1 ${#cols[*]}) )
declare -A hcols=()
declare -A hnums=()

for ((i = 0; i < ${#cols[*]}; i++)); do
    hcols+=([${cols[$i]}]=${nums[$i]})
    hnums+=([${nums[$i]}]=${cols[$i]})
done

[[ $1 =~ ^[0-9]+$     ]] && echo "${hnums[$1]}"
[[ $1 =~ ^[A-Z]{1,3}$ ]] && echo "${hcols[$1]}"
