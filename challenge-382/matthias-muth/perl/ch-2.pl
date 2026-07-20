#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 382 Task 2: Replace Question Mark
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub replace_question_mark( $str ) {
    return
        $str =~ /\?/
        ? ( replace_question_mark( $str =~ s//0/r ),
            replace_question_mark( $str =~ s//1/r ) )
        : ( $str );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "01??0", ["01000", "01010", "01100", "01110"] ],
    [ "Example 2", "101", ["101"] ],
    [ "Example 3",
        "???",
        ["000", "001", "010", "011", "100", "101", "110", "111"] ],
    [ "Example 4", "1?10", ["1010", "1110"] ],
    [ "Example 5", "1?1?0", ["10100", "10110", "11100", "11110"] ],
);

is [ replace_question_mark( $_->[1] ) ], $_->[2], $_->[0]
    for @tests;
done_testing;
