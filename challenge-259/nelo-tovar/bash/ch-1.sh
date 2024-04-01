#!/usr/bin/env bash 
#
# The Weekly Challenge 259 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
#
# Task 1 : Banking Day Offset

function banking_day_offset() {
    local date_offset=$1
    local offset=$2
    local bank_holidays=$3

    for (( i = 1; i <= $offset; i++ )); do
        date_offset=$(date +%Y-%m-%d -d "$date_offset + 1 day")

        while [[ $(date +%u -d $date_offset) =~ [67] ]]; do
            date_offset=$(date +%Y-%m-%d -d "$date_offset + 1 day")
        done

        if [[ $bank_holidays && "$date_offset" == *"$bank_holidays"* ]]; then
            date_offset=$(date +%Y-%m-%d -d "$date_offset + 1 day")
        fi
    done

    echo $date_offset
}

example=('2018-06-28' '2018-06-28')
example_offset=(3 3)
example_bank_holidays=('2018-07-03')

for e in 0 1; do
    start_date=${example[$e]}
    offset=${example_offset[$e]}
    bank_holidays=${example_bank_holidays[$e]}

    bdo=$(banking_day_offset "$start_date" $offset $bank_holidays)
    echo -n "Input  : start_date = $start_date, offset = $offset"
    if [ $bank_holidays ]; then
        echo -n ", bank_holidays = $bank_holidays"
    fi
    echo " "
    echo "Output : $bdo"
    echo ""
done

