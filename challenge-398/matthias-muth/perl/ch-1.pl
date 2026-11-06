#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 398 Task 1: Divisible Average
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub divisible_average( @arr ) {
    @arr = grep { $_ % 6 == 0 } @arr;
    return @arr ? int( sum( @arr ) / @arr + 0.5 ) : 0;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [18, 5, 7, 11], 18 ],
    [ "Example 2", [6, 12, 18, 24, 30, 40], 18 ],
    [ "Example 3", [3, 9, 15, 21, 27], 0 ],
    [ "Example 4", [6, 12, 14, 20], 9 ],
    [ "Example 5", [6, 6, 6, 12, 12], 8 ],
);

is divisible_average( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
