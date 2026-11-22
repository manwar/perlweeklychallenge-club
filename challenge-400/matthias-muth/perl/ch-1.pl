#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 400 Task 1: Largest Interval
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub largest_interval( $int ) {
    my ( $current_gap, $largest_gap ) = ( 0, 0 );
    for ( 1..$int) {
        if ( /(\d).*\1/ ) {
            ++$current_gap;
        }
        else {
            $largest_gap = $current_gap
                if $current_gap > $largest_gap;
            $current_gap = 0;
        }
    }
    # The 'biggest jump' is one larger than the largest gap.
    # (Note that we still have 'jumps' of 1 if there is no gap at all.)
    return $largest_gap + 1;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", 20, 2 ],
    [ "Example 2", 110, 4 ],
    [ "Example 3", 500, 11 ],
    [ "Example 4", 2026, 105 ],
    [ "Example 5", 10000, 105 ],
    [ "Own Test 1", 9, 1 ],
);

is largest_interval( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;
