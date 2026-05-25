#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 374 Task 2: Largest Same-digits Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub largest_same_digits_number( $str ) {
    my $max = 0;
    while ( $str =~ /(\d)\g{-1}*/g ) {
        $max = $& if $& > $max;
    }
    return $max;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", 6777133339, 3333 ],
    [ "Example 2", 1200034, 4 ],
    [ "Example 3", 44221155, 55 ],
    [ "Example 4", 88888, 88888 ],
    [ "Example 5", 11122233, 222 ],
);

is largest_same_digits_number( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;
