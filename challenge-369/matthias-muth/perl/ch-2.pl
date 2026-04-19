#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 369 Task 2: Group Division
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub group_division( $str, $size, $filler ) {
    return ( $str . $filler x ( $size - 1 ) ) =~ /.{$size}/g;
}

use Test2::V0 qw( -no_srand );

is [ group_division( "RakuPerl", 4, "*" ) ], [ "Raku", "Perl" ],
    'Example 1: group_division( "RakuPerl", 4, "*" )  => ("Raku", "Perl")';
is [ group_division( "Python", 5, 0 ) ], [ "Pytho", "n0000" ],
    'Example 2: group_division( "Python", 5, 0 )  => ("Pytho", "n0000")';
is [ group_division( 12345, 3, "x" ) ], [ 123, "45x" ],
    'Example 3: group_division( 12345, 3, "x" )  => (123, "45x")';
is [ group_division( "HelloWorld", 3, "_" ) ], [ "Hel", "loW", "orl", "d__" ],
    'Example 4: group_division( "HelloWorld", 3, "_" )  => ("Hel", "loW", "orl", "d__")';
is [ group_division( "AI", 5, "!" ) ], [ "AI!!!" ],
    'Example 5: group_division( "AI", 5, "!" ) eq "AI!!!"';

done_testing;
