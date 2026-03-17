#!/usr/bin/env gawk

# Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

function join(array, start, end, sep,    result, i) {
    if (sep == "")
       sep = " ";
    else if (sep == SUBSEP) # magic value
       sep = "";
    result = array[start];
    for (i = start + 1; i <= end; i++)
        result = result sep array[i];
    return result;
}

function alen(a, i, k) {
    k = 0;
    for(i in a) k++;
    return k;
}

BEGIN {
    text = join(ARGV, 1, alen(ARGV));
    print gsub(/e/, "E", text) " " text;
    exit 0;
}
