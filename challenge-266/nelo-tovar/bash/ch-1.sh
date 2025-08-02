#!/usr/bin/env bash 
#
# The Weekly Challenge 266 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
#
# Task 1 : Uncommon Words

function unique() {
    local sentence=$1
    local uniq=()
    declare -A local words

    for word in $sentence; do
        ((words[$word]++))
    done

    for key in ${!words[@]}; do
        if [[ ${words[$key]} -eq 1 ]]; then
            uniq+=($key)
        fi
    done

    echo "${uniq[@]}"
}

function uncommon_words() {
    local line1=$1
    local line2=$2
    local uncommons=()

    line1=${line1,,}
    line2=${line2,,}

    words1=($(unique "$line1"))
    words2=($(unique "$line2"))

    for key in ${words1[@]}; do
        if [[ ! $line2 =~ $key ]]; then
            uncommons+=($key)
        fi
    done

    for key in ${words2[@]}; do
        if [[ ! $line1 =~ $key ]]; then
            uncommons+=($key)
        fi
    done

    echo ${uncommons[@]} 
}

examples_line1=('Mango is sweet' 'Mango Mango' 'Mango is Mango')
examples_line2=('Mango is sour' 'Orange' 'Orange is Orange' )

for (( i = 0; i < ${#examples_line1[@]}; i++ )); do
    uw=($(uncommon_words "${examples_line1[$i]}" "${examples_line2[$i]}"))
    echo "Input  : line1 = ${examples_line1[$i]}"
    echo "         line2 = ${examples_line2[$i]}"
    echo "Output : (${uw[@]})"
    echo ""
done

