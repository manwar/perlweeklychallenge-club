#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 377 Task 1: Reverse Existence
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( any );

sub reverse_existence( $str ) {
    my %substring_exists =
        map { ( substr( $str, $_, 2 ) => 1 ) } 0 .. length( $str ) - 2;
    return any { $substring_exists{$_} }
        map scalar reverse( $_ ), keys %substring_exists;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "abcba", T ],
    [ "Example 2", "racecar", T ],
    [ "Example 3", "abcd", F ],
    [ "Example 4", "banana", T ],
    [ "Example 5", "hello", T ],
);

is reverse_existence( $_->[1] ), $_->[2], $_->[0]
    for @tests;
done_testing;
