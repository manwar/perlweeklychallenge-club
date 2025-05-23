#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 321 Task 2: Backspace Compare
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub backspace_compare_1( $str1, $str2 ) {
    for ( $str1, $str2 ) {
        while ( s/[^#]#//g ) {
            # Everything is in the loop condition.
        }
    }
    return $str1 eq $str2;
}

sub backspace_compare( $str1, $str2 ) {
    for ( $str1, $str2 ) {
        do {} while s/[^#]#//g;
    }
    return $str1 eq $str2;
}

sub backspace_compare_compact( $str1, $str2 ) {
    do {} while $str1 =~ s/[^#]#//g;
    do {} while $str2 =~ s/[^#]#//g;
    return $str1 eq $str2;
}

use Test2::V0 qw( -no_srand );

is backspace_compare( "ab#c", "ad#c" ), T,
    'Example 1: backspace_compare( "ab#c", "ad#c" ) is true';
is backspace_compare( "ab##", "a#b#" ), T,
    'Example 2: backspace_compare( "ab##", "a#b#" ) is true';
is backspace_compare( "a#b", "c" ), F,
    'Example 3: backspace_compare( "a#b", "c" ) is false';
is backspace_compare( "abc###", "" ), T,
    'Added Test 1: backspace_compare( "abc###", "" ) is true';

done_testing;
