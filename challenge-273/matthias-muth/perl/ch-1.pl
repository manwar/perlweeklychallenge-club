#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 273 Task 1: Percentage of Character
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub percentage_of_character( $str, $char ) {
    my %freq;
    ++$freq{$_}
        for split "", $str;
    return int( 100 * ( $freq{$char} // 0 ) / length( $str ) + 0.5 );
}

use Test2::V0 qw( -no_srand );
is percentage_of_character( "perl", "e" ), 25,
    'Example 1: percentage_of_character( "perl", "e" ) == 25';
is percentage_of_character( "java", "a" ), 50,
    'Example 2: percentage_of_character( "java", "a" ) == 50';
is percentage_of_character( "python", "m" ), 0,
    'Example 3: percentage_of_character( "python", "m" ) == 0';
is percentage_of_character( "ada", "a" ), 67,
    'Example 4: percentage_of_character( "ada", "a" ) == 67';
is percentage_of_character( "ballerina", "l" ), 22,
    'Example 5: percentage_of_character( "ballerina", "l" ) == 22';
is percentage_of_character( "analitik", "k" ), 13,
    'Example 6: percentage_of_character( "analitik", "k" ) == 13';
done_testing;
