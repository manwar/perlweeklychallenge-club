#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 342 Task 2: Max Score
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( reductions max );

sub max_score( $str ) {
    my @digits = split "", $str;
    my @n_ones = reductions { $a + $b } @digits;
    my $total_n_ones = $n_ones[-1];
    my @scores = map {
        ( $_ + 1 - $n_ones[$_] )                # Number of zeroes up to here
            + ( $total_n_ones - $n_ones[$_] )   # Number of ones to the right
    } keys @digits;
    $scores[-1] = 0;
    return max( @scores );
}

use Test2::V0 qw( -no_srand );

is max_score( "00" ), 1,
    'Test 1: max_score( "00" ) == 1';
is max_score( "10" ), 0,
    'Test 2: max_score( "10" ) == 0';
is max_score( "01" ), 2,
    'Test 3: max_score( "01" ) == 2';
is max_score( "11" ), 1,
    'Test 4: max_score( "11" ) == 1';
is max_score( "1111" ), 3,
    'Test 5: max_score( "1111" ) == 3';

is max_score( "0011" ), 4,
    'Example 1: max_score( "0011" ) == 4';
is max_score( "0000" ), 3,
    'Example 2: max_score( "0000" ) == 3';
is max_score( 1111 ), 3,
    'Example 3: max_score( 1111 ) == 3';
is max_score( "0101" ), 3,
    'Example 4: max_score( "0101" ) == 3';
is max_score( "011101" ), 5,
    'Example 5: max_score( "011101" ) == 5';

done_testing;
