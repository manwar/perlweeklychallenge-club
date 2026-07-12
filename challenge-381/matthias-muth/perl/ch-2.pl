#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 381 Task 2: Smaller Greater Element
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub smaller_greater_element( @int ) {
    my ( $min, $max, %freq ) = ( $int[0], $int[0] );
    for ( @int ) {
        $max >= $_ or $max = $_;
        $min <= $_ or $min = $_;
        ++$freq{$_};
    }
    return
        scalar %freq <= 2
        ? 0
        : @int - $freq{$min} - $freq{$max};
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [2, 4], 0 ],
    [ "Example 2", [1, 1, 1, 1], 0 ],
    [ "Example 3", [1, 1, 4, 8, 12, 12], 2 ],
    [ "Example 4", [3, 6, 6, 9], 2 ],
    [ "Example 5", [0, -5, 10, -2, 4], 3 ],
);

is smaller_greater_element( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
