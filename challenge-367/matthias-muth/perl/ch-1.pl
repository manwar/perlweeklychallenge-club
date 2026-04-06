#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 367 Task 1: Max Odd Binary
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub max_odd_binary( $str ) {
    my ( $n_bits, $n_ones ) = ( length( $str ), $str =~ tr/1// );
    return "1" x ( $n_ones - 1 )
        . "0" x ( $n_bits - $n_ones )
        . "1";
}

use Test2::V0 qw( -no_srand );

is max_odd_binary( "1011" ), "1101",
    'Example 1: max_odd_binary( "1011" ) eq "1101"';
is max_odd_binary( "100" ), "001",
    'Example 2: max_odd_binary( "100" ) eq "001"';
is max_odd_binary( "111000" ), "110001",
    'Example 3: max_odd_binary( "111000" ) eq "110001"';
is max_odd_binary( "0101" ), "1001",
    'Example 4: max_odd_binary( "0101" ) eq "1001"';
is max_odd_binary( "1111" ), "1111",
    'Example 5: max_odd_binary( "1111" ) eq "1111"';

done_testing;
