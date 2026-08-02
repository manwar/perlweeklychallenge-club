#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 384 Task 1: Base N
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Math::Prime::Util qw( todigits );

sub base_n( $num, $base ) {
    return undef unless 0 < $base <= 64;
    my $digits = join "", 0..9, "A".."Z", "a".."z", "+", "/";
    return join "", map substr( $digits, $_, 1 ), todigits( $num, $base );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [42, 2], 101010 ],
    [ "Example 2", [15642094, 16], "EEADEE" ],
    [ "Example 3", [493, 8], 755 ],
    [ "Example 4", [2228519, 36], "1BRJB" ],
    [ "Example 5", [123456789, 64], "7MyqL" ],
);

is base_n( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
