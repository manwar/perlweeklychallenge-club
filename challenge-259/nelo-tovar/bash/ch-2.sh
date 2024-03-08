#!/usr/bin/env bash 
#
# The Weekly Challenge 259 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
#
# Task 2 : Line Parser

function line_parser() {
    local original_line=$1
    local line_parsed='{\n'

    if [[ "$original_line" =~  ^\{%[[:space:]]+([[:alpha:]]+)[[:space:]]+[[:alpha:]]+[[:space:]]* ]]; then
        line_parsed+="\tname => ${BASH_REMATCH[1]}\n"
        line_parsed+="\tfields => {\n"
        
        while [[ $original_line =~ ([[:alpha:]]+)=\"?([[:alnum:][:space:]\"\\]+) ]]; do
            line_parsed+="\t\t${BASH_REMATCH[1]} => ${BASH_REMATCH[2]},\n"
            original_line=${original_line/${BASH_REMATCH[1]}=/}
            original_line=${original_line/${BASH_REMATCH[2]}/}
        done
        line_parsed+="\t}\n"
    fi
    line_parsed+='}'
    echo $line_parsed
}

examples=(
    '{%  youtube title="Title \"quoted\" done" %}' 
    '{%  youtube title="Title with escaped backslash \\" %}'
    )

for e in 0 1; do
    lp=$(line_parser "${examples[$e]}")
    echo -e "$lp"
done

