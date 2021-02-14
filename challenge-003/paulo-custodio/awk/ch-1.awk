#!/usr/bin/gawk

# Challenge 003
#
# Challenge #1
# Create a script to generate 5-smooth numbers, whose prime divisors are less
# or equal to 5. They are also called Hamming/Regular/Ugly numbers. For more
# information, please check this wikipedia.

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
