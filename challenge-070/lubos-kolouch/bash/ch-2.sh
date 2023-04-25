#!/bin/bash

N=4
gray_code=("0" "1")

for ((i=2; i<=N; i++)); do
    rev_gray_code=("${gray_code[@]}")
    for ((j=${#rev_gray_code[@]}-1; j>=0; j--)); do
        rev_gray_code[j]="1${rev_gray_code[j]}"
    done
    for ((j=0; j<${#gray_code[@]}; j++)); do
        gray_code[j]="0${gray_code[j]}"
    done
    gray_code+=("${rev_gray_code[@]}")
done

for x in "${gray_code[@]}"; do
    echo -n "$((2#$x)) "
done
echo
