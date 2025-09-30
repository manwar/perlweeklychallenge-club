#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 340 Task 1: Duplicate Removals
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub duplicate_removals( $str ) {
    do {} while $str =~ s/(.)\g-1//g;
    return $str;
}

use Test2::V0 qw( -no_srand );

is duplicate_removals( "abbaca" ), "ca",
    'Example 1: duplicate_removals( "abbaca" ) == "ca"';
is duplicate_removals( "azxxzy" ), "ay",
    'Example 2: duplicate_removals( "azxxzy" ) == "ay"';
is duplicate_removals( "aaaaaaaa" ), "",
    'Example 3: duplicate_removals( "aaaaaaaa" ) == ""';
is duplicate_removals( "aabccba" ), "a",
    'Example 4: duplicate_removals( "aabccba" ) == "a"';
is duplicate_removals( "abcddcba" ), "",
    'Example 5: duplicate_removals( "abcddcba" ) == ""';

done_testing;
