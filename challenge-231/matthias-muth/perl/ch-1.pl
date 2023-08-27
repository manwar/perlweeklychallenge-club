#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 231 Task 1: Min Max
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

sub min_max_1( @ints ) {
    return -1
       unless @ints > 2;
    my ( $min, $min_index, $max, $max_index ) =
        ( $ints[0], 0 ) x 2;
    for ( 1 .. $#ints ) {
	( $min, $min_index ) = ( $ints[$_], $_ )
	    if $ints[$_] < $min;
	( $max, $max_index ) = ( $ints[$_], $_ )
	    if $ints[$_] > $max;
	# vsay "$min_index $max_index";
    }
    # vsay "splice \@ints, $_, 1, ()"
    #     for reverse sort { $a <=> $b } $min_index, $max_index;
    splice @ints, $_, 1, ()
        for reverse sort { $a <=> $b } $min_index, $max_index;
    return @ints;
}

sub min_max_2( @ints ) {
    return -1
       unless @ints > 2;
    my ( $min, $max ) = ( $ints[0], $ints[0] );
    my @min_max_indices = ( 0, 0 );
    for ( 1 .. $#ints ) {
	( $min, $min_max_indices[0] ) = ( $ints[$_], $_ )
	    if $ints[$_] < $min;
	( $max, $min_max_indices[1] ) = ( $ints[$_], $_ )
	    if $ints[$_] > $max;
	vsay "@min_max_indices";
    }

    @min_max_indices = reverse @min_max_indices
        if $min_max_indices[0] < $min_max_indices[1];

    splice @ints, $_, 1, ()
        for @min_max_indices;
    return @ints;
}

use List::Util qw( min max );

sub min_max( @ints ) {
    return -1
       unless @ints > 2;
    my ( $min, $max ) = ( min( @ints ), max( @ints ) );
    return grep { $_ != $min && $_ != $max } @ints;
}

run_tests;
