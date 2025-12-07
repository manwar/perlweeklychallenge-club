#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 350 Task 1: Good Substrings
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub good_substrings( $str ) {
    my $count = 0;
    # Using $a, $b and $c as a round robin.
    my ( $a, $b, $c ) = split "", substr( $str, 0, 3, "" );
    while ( $c ne "" ) {
        ++$count if $a ne $b && $a ne $c && $b ne $c;
        ( $a, $b, $c ) = ( $b, $c, substr( $str, 0, 1, "" ) );
    }
    return $count;
}

use Test2::V0 qw( -no_srand );

is good_substrings( "abcaefg" ), 5,
    'Example 1: good_substrings( "abcaefg" ) == 5';
is good_substrings( "xyzzabc" ), 3,
    'Example 2: good_substrings( "xyzzabc" ) == 3';
is good_substrings( "aababc" ), 1,
    'Example 3: good_substrings( "aababc" ) == 1';
is good_substrings( "qwerty" ), 4,
    'Example 4: good_substrings( "qwerty" ) == 4';
is good_substrings( "zzzaaa" ), 0,
    'Example 5: good_substrings( "zzzaaa" ) == 0';

done_testing;
