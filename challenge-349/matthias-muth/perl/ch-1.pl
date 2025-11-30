#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 349 Task 1: Power String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub power_string( $str ) {
    return max( map length, $str =~ /((.)\g-1*)/g );
}

use Test2::V0 qw( -no_srand );

is power_string( "textbook" ), 2,
    'Example 1: power_string( "textbook" ) == 2';
is power_string( "aaaaa" ), 5,
    'Example 2: power_string( "aaaaa" ) == 5';
is power_string( "hoorayyy" ), 3,
    'Example 3: power_string( "hoorayyy" ) == 3';
is power_string( "x" ), 1,
    'Example 4: power_string( "x" ) == 1';
is power_string( "aabcccddeeffffghijjk" ), 4,
    'Example 5: power_string( "aabcccddeeffffghijjk" ) == 4';

done_testing;
