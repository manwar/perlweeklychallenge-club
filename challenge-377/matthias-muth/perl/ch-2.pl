#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 377 Task 2: Prefix Suffix
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub prefix_suffix( @array ) {
    return sum(
        map {
            my $str1 = $array[$_];
            scalar grep /^$str1/ && /$str1$/, @array[ $_ + 1 .. $#array ];
        } keys @array
    );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["a", "aba", "ababa", "aa"], 4 ],
    [ "Example 2", ["pa", "papa", "ma", "mama"], 2 ],
    [ "Example 3", ["abao", "ab"], 0 ],
    [ "Example 4", ["abab", "abab"], 1 ],
    [ "Example 5", ["ab", "abab", "ababab"], 3 ],
    [ "Example 6", ["abc", "def", "ghij"], 0 ],
);

is prefix_suffix( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
