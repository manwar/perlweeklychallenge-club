#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 330 Task 1: Clear Digits
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub clear_digits( $str ) {
    while ( $str =~ s/[a-z]\d// ) {
        # Everything is in the loop condition.
    }
    return $str;
}

use Test2::V0 qw( -no_srand );

is clear_digits( "cab12" ), "c",
    'Example 1: clear_digits( "cab12" ) == "c"';
is clear_digits( "xy99" ), "",
    'Example 2: clear_digits( "xy99" ) == ""';
is clear_digits( "pa1erl" ), "perl",
    'Example 3: clear_digits( "pa1erl" ) == "perl"';

done_testing;
