#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 258 Task 2: Sum of Values
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub n_bits( $n ) {
    return unpack "%b*", pack "i", $n;
}

sub sum_of_values( $ints, $k ) {
    return sum map $ints->[$_], grep n_bits( $_ ) == $k, 0..$ints->$#*;
}

use Test2::V0 qw( -no_srand );
is sum_of_values( [2, 5, 9, 11, 3], 1 ), 17,
    'Example 1: sum_of_values( [2, 5, 9, 11, 3], 1 ) == 17';
is sum_of_values( [2, 5, 9, 11, 3], 2 ), 11,
    'Example 2: sum_of_values( [2, 5, 9, 11, 3], 2 ) == 11';
is sum_of_values( [2, 5, 9, 11, 3], 0 ), 2,
    'Example 3: sum_of_values( [2, 5, 9, 11, 3], 0 ) == 2';
done_testing;
