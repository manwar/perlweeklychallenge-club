#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 341 Task 2: Reverse Prefix
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub reverse_prefix( $str, $char ) {
    return $str =~ s<^.*?$char>{ reverse $& }er;
}

use Test2::V0 qw( -no_srand );

is reverse_prefix( "programming", "g" ), "gorpramming",
    'Example 1: reverse_prefix( "programming", "g" ) == "gorpramming"';
is reverse_prefix( "hello", "h" ), "hello",
    'Example 2: reverse_prefix( "hello", "h" ) == "hello"';
is reverse_prefix( "abcdefghij", "h" ), "hgfedcbaij",
    'Example 3: reverse_prefix( "abcdefghij", "h" ) == "hgfedcbaij"';
is reverse_prefix( "reverse", "s" ), "srevere",
    'Example 4: reverse_prefix( "reverse", "s" ) == "srevere"';
is reverse_prefix( "perl", "r" ), "repl",
    'Example 5: reverse_prefix( "perl", "r" ) == "repl"';

done_testing;
