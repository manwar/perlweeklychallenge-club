#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 392 Task 1: Convert Palindrome
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub is_palindrome( $str ) {
    return substr( $str, 0, length( $str) / 2 )
        eq reverse substr( $str, -length( $str) / 2 );
}

sub convert_palindrome( $str ) {
    my $reversed = reverse $str;
    my $prepend = "";
    until ( is_palindrome( $prepend . $str ) ) {
        $prepend .= substr( $reversed, 0, 1, "" );
    }
    return $prepend . $str;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "pinnipeds", "sdepinnipeds" ],
    [ "Example 2", "abcd", "dcbabcd" ],
    [ "Example 3", "bananas", "sananabananas" ],
    [ "Example 4", "dissident", "tnedissident" ],
    [ "Example 5", "cailliachs", "shcailliachs" ],
    [ "Own Test 1", "racecar", "racecar" ],
);

is convert_palindrome( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;
