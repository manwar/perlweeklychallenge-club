#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 380 Task 2: Reverse Degree
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub reverse_degree( $str ) {
    my $position = 1;
    return sum(
        map $position++ * ( ord( "z" ) + 1 - ord( $_ ) ),
            split //, $str
    );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "z", 1 ],
    [ "Example 2", "a", 26 ],
    [ "Example 3", "bbc", 147 ],
    [ "Example 4", "racecar", 560 ],
    [ "Example 5", "zyx", 14 ],
);

is reverse_degree( $_->[1] ), $_->[2], $_->[0]
    for @tests;
done_testing;
