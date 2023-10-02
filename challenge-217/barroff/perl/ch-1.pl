#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

sub sorted_matrix (@s) {
    my @as_vector;
    map append( @as_vector, @$_ ), @s;
    my @sorted = sort @as_vector;
    return $sorted[2];
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw(is plan);
    plan 3;

    is sorted_matrix( ( [ 3, 1, 2 ], [ 5, 2, 4 ], [ 0, 1, 3 ] ) ), 1,
      "works for ([3, 1, 2], [5, 2, 4], [0, 1, 3])";
    is sorted_matrix( ( [ 2, 1 ], [ 4, 5 ] ) ), 4, "works for ([2, 1], [4, 5])";
    is sorted_matrix( ( [ 1, 0, 3 ], [ 0, 0, 0 ], [ 1, 2, 1 ] ) ), 0,
      "works for ([1, 0, 3], [0, 0, 0], [1, 2, 1])";
}

MAIN();
