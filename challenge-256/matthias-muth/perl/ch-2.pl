#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 256 Task 2: Merge Strings
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( mesh );

sub merge_strings( $str1, $str2 ) {
    return join "",
	grep defined,
	    mesh [ split //, $str1 ], [ split //, $str2 ];
}

use Test2::V0 qw( -no_srand );
is merge_strings( "abcd", 1234 ), "a1b2c3d4",
    'Example 1: merge_strings( ("abcd", 1234) ) == "a1b2c3d4"';
is merge_strings( "abc", 12345 ), "a1b2c345",
    'Example 2: merge_strings( ("abc", 12345) ) == "a1b2c345"';
is merge_strings( "abcde", 123 ), "a1b2c3de",
    'Example 3: merge_strings( ("abcde", 123) ) == "a1b2c3de"';
done_testing;
