#!/usr/bin/env perl6

sub countsq(@ar) {
    return ((^@ar).combinations(2) X (^@ar[0]).combinations(2))
    .map({ $_.[0] X $_.[1] })
    .grep({ ($_.[2][0] - $_.[0][0]) == ($_.[1][1] - $_.[0][1]) })
    .map(*.map({ @ar.[$_.[0]].[$_.[1]] }))
    .map(*.reduce(* * *))
    .grep(1)
    .elems
}

say countsq(@*ARGS.map(*.split('',:skip-empty)));

# run as <script> <space-separated binary words representing rows>
# e.g. <script> 1101 1100 0111 1011 to enter the matrix
# [ 1 1 0 1 ]
# [ 1 1 0 0 ]
# [ 0 1 1 1 ]
# [ 1 0 1 1 ]
