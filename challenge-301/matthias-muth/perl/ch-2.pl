#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 301 Task 2: Hamming Distance
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Algorithm::Combinatorics qw( combinations );

sub count_bits( $n ) {
    return unpack( "%b*", pack( "I", $n ) );
}

sub hamming_distance( @ints ) {
    my $sum = 0;
    for ( combinations( \@ints, 2 ) ) {
	my ( $a, $b ) = $_->@*;
	$sum += count_bits( $a ^ $b );
    }
    return $sum;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is hamming_distance( 4, 14, 2 ), 6,
    'Example 1: hamming_distance( 4, 14, 2 ) == 6';
is hamming_distance( 4, 14, 4 ), 4,
    'Example 2: hamming_distance( 4, 14, 4 ) == 4';

done_testing;
