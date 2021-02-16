#!/usr/bin/gawk

# Challenge 001
#
# Challenge #1
# Write a script to replace the character 'e' with 'E' in the string
# "Perl Weekly Challenge". Also print the number of times the character 'e'
# is found in the string.

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
