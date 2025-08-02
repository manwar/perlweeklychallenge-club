#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 301 Task 1: Largest Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub recurse( @ints ) {
    return $ints[0]
	 if @ints == 1;
    my $first_digit = substr( $ints[0], 0, 1 );
    my @starters = ( shift @ints );
    push @starters, shift @ints
	while @ints && substr( $ints[0], 0, 1 ) eq $first_digit;
    return $starters[0] . recurse( @ints )
	if @starters == 1;
    my $best = 0;
    for ( 0..$#starters ) {
	my $try = $starters[$_] . recurse(
	    @starters[0..$_-1],
	    @starters[$_+1..$#starters],
	    @ints );
	$best = $try
	    if $try > $best;
    }
    return $best;
}

sub largest_number( @ints ) {
    my @results;
    # Do an *alphanumeric* sort, highest first.
    @ints = reverse sort @ints;
    return recurse( @ints );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is largest_number( 20, 3 ), 320,
    'Example 1: largest_number( 20, 3 ) == 320';
is largest_number( 3, 30, 34, 5, 9 ), 9534330,
    'Example 2: largest_number( 3, 30, 34, 5, 9 ) == 9534330';

done_testing;
