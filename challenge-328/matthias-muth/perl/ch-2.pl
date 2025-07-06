#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 328 Task 2: Good String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

    sub good_string( $str ) {
        while ( $str =~ s/( [a-z](?=[A-Z]) | [A-Z](?=[a-z]) ) (?i)\1 //x ) {
            # Everything is in the loop condition.
        }
        return $str;
    }

use Test2::V0 qw( -no_srand );

is good_string( "WeEeekly" ), "Weekly",
    'Example 1: good_string( "WeEeekly" ) == "Weekly"';
is good_string( "abBAdD" ), "",
    'Example 2: good_string( "abBAdD" ) == ""';
is good_string( "abc" ), "abc",
    'Example 3: good_string( "abc" ) == "abc"';

done_testing;
