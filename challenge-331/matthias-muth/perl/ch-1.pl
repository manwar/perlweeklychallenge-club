#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 331 Task 1: Last Word
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub last_word_length( $str ) {
    return length( ( split " ", $str )[-1] // "" );
}

use Test2::V0 qw( -no_srand );

is last_word_length( "The Weekly Challenge" ), 9,
    'Example 1: last_word_length( "The Weekly Challenge" ) == 9';
is last_word_length( "   Hello   World    " ), 5,
    'Example 2: last_word_length( "   Hello   World    " ) == 5';
is last_word_length( "Let" ), 3,
    'Example 3: last_word_length( "Let" ) == 3';
is last_word_length( "" ), 0,
    'Test 1: last_word_length( "" ) == 0';

done_testing;
