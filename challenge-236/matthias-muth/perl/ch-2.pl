#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 236 Task 2: Array Loops
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

sub array_loops_1( @ints ) {
    my @loops;
    my @visited = ();

    for my $start_index ( 0..$#ints ) {
	next if $visited[$start_index];

	my @loop_indexes = ( $start_index );

	vsay "starting at index $start_index";
	my $i = $ints[$start_index];
	while ( exists( $ints[$i] )
	    && ! $visited[$ints[$i]]
	    && $i != $start_index )
	{
	    vsay "  moving to index $i";
	    push @loop_indexes, $i;
	    $visited[$i] = 1;
	    $i = $ints[$i];
	}

	if ( $i == $start_index ) {
	    vsay "  we found a loop: @loop_indexes";
	    push @loops, [ @loop_indexes ];
	}
    }
    return scalar @loops;
}


sub array_loops( @ints ) {
    my $n_loops = 0;
    my @visited = ();

    for my $start_index ( 0..$#ints ) {
	next if $visited[$start_index];

	vsay "starting at index $start_index";
	my $i = $ints[$start_index];
	while ( exists( $ints[$i] )
	    && ! $visited[$ints[$i]]
	    && $i != $start_index )
	{
	    vsay "  moving to index $i";
	    $visited[$i] = 1;
	    $i = $ints[$i];
	}

	if ( $i == $start_index ) {
	    vsay "  we found a loop";
	    ++$n_loops;
	}
    }
    return $n_loops;
}

run_tests;

__DATA__
Test 1: Simple sequence
Input: @ints = ( 0, 1, 2, 3, 4, 5 )
Output: 6

Test 2: No loop
Input: @ints = ( 1, 2, 3, 4, 5 )
Output: 0

Test 2: One real loop
Input: @ints = ( 1, 2, 0, 4, 5 )
Output: 1

