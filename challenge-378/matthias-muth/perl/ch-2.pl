#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 378 Task 2: Sum of Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub sum_of_words( $str1, $str2, $str3 ) {
    my @values =
        map { join "", map ord( $_ ) - ord( "a" ), split "", $_ }
            $str1, $str2, $str3;
    return $values[0] + $values[1] == $values[2]
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["acb", "cba", "cdb"], T ],
    [ "Example 2", ["aab", "aac", "ad"], T ],
    [ "Example 3", ["bc", "je", "jg"], F ],
    [ "Example 4", ["a", "aaaa", "aa"], T ],
    [ "Example 5", ["c", "d", "h"], F ],
    [ "Example 6", ["gfi", "hbf", "bdhd"], T ],
);

is sum_of_words( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
