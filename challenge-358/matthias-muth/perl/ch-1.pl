#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 358 Task 1: Max Str Value
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( max );

sub max_str_value( @strings ) {
    return max( map /^\d+$/ ? $_ : length, @strings );
}

use Test2::V0 qw( -no_srand );

is max_str_value( 123, 45, 6 ), 123,
    'Example 1: max_str_value( 123, 45, 6 ) == 123';
is max_str_value( "abc", "de", "fghi" ), 4,
    'Example 2: max_str_value( "abc", "de", "fghi" ) == 4';
is max_str_value( "0012", 99, "a1b2c" ), 99,
    'Example 3: max_str_value( "0012", 99, "a1b2c" ) == 99';
is max_str_value( "x", 10, "xyz", "007" ), 10,
    'Example 4: max_str_value( "x", 10, "xyz", "007" ) == 10';
is max_str_value( "hello123", 2026, "perl" ), 2026,
    'Example 5: max_str_value( "hello123", 2026, "perl" ) == 2026';

done_testing;
