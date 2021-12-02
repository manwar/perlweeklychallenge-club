#!/usr/bin/gawk

# Challenge 123
#
# TASK #1 > Ugly Numbers
# Submitted by: Mohammad S Anwar
# You are given an integer $n >= 1.
#
# Write a script to find the $nth element of Ugly Numbers.
#
# Ugly numbers are those number whose prime factors are 2, 3 or 5. For example,
# the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
#
# Example
# Input: $n = 7
# Output: 8
#
# Input: $n = 10
# Output: 12

function min(a, b) {
    return (a<b) ? a : b;
}

function min3(a, b, c) {
    return min(a, min(b, c));
}

function alen(a,     i, k) {
    k = 0;
    for(i in a) k++;
    return k;
}

function push(a, v,    n) {
    n = alen(a);
    while (n in a) n++;
    a[n] = v;
}

function shift(a,    i, v) {
    v = a[0];
    for (i=1; i<alen(a); i++)
        a[i-1] = a[i];
    delete a[alen(a)-1];
    return v;
}

function hamming(    n) {
    # get the smallest of the multiples
    n = min3(seq2[0], seq3[0], seq5[0]);

    # shift used multiples
    if (seq2[0] == n) shift(seq2);
    if (seq3[0] == n) shift(seq3);
    if (seq5[0] == n) shift(seq5);

    # push next multiple
    push(seq2, n*2);
    push(seq3, n*3);
    push(seq5, n*5);

    return n;
}

BEGIN {
    # sequences of hamming numbers 2*n, 3*n, 5*n
    seq2[0] = 1;
    seq3[0] = 1;
    seq5[0] = 1;

    n = ARGV[1] ? ARGV[1] : 5;
    for (i=0; i<n; i++)
        print hamming();
    exit 0;
}
