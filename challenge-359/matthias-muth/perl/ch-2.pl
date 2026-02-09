#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 359 Task 2: String Reduction
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub string_reduction( $word ) {
    do {} while $word =~ s/(.)\g-1//g;
    return $word;
}

use Test2::V0 qw( -no_srand );

is string_reduction( "aabbccdd" ), "",
    'Example 1: string_reduction( "aabbccdd" ) eq ""';
is string_reduction( "abccba" ), "",
    'Example 2: string_reduction( "abccba" ) eq ""';
is string_reduction( "abcdef" ), "abcdef",
    'Example 3: string_reduction( "abcdef" ) eq "abcdef"';
is string_reduction( "aabbaeaccdd" ), "aea",
    'Example 4: string_reduction( "aabbaeaccdd" ) eq "aea"';
is string_reduction( "mississippi" ), "m",
    'Example 5: string_reduction( "mississippi" ) eq "m"';

done_testing;
