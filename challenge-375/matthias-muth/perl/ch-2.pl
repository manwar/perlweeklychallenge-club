#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 375 Task 2: Find K-Beauty
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub find_k_beauty( $num, $k ) {
    my $k_beauty = 0;
    for ( 0..length( $num ) - $k ) {
        ++$k_beauty
            if $num % substr ( $num, $_, $k ) == 0;
    }
    return $k_beauty;
}

use List::Util qw( sum );
sub find_k_beauty( $num, $k ) {
    return sum(
        map $num % substr ( $num, $_, $k ) == 0,
            0 .. length( $num ) - $k
    );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [240, 2], 2 ],
    [ "Example 2", [1020, 2], 3 ],
    [ "Example 3", [444, 2], 0 ],
    [ "Example 4", [17, 2], 1 ],
    [ "Example 5", [123, 1], 2 ],
);

is find_k_beauty( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
