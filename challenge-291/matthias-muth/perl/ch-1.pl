#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 291 Task 1: Middle Index
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub middle_index( @ints ) {
    my ( $right_sum, $left_sum ) = ( sum( @ints ), 0 );
    for ( 0..$#ints ) {
        # Remove the current entry from the right sum.
        $right_sum -= $ints[$_];

        # Check left and right.
        return $_
            if $left_sum == $right_sum;

        # Prepare for the next iteration.
        $left_sum += $ints[$_];
    }
    return -1;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is middle_index( 2, 3, -1, 8, 4 ), 3,
    'Example 1: middle_index( 2, 3, -1, 8, 4 ) == 3';
is middle_index( 1, -1, 4 ), 2,
    'Example 2: middle_index( 1, -1, 4 ) == 2';
is middle_index( 2, 5 ), -1,
    'Example 3: middle_index( 2, 5 ) == -1';

done_testing;
