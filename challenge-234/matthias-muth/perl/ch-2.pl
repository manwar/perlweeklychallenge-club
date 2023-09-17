#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 234 Task 2: Unequal Triplets
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

use List::Util qw( product );

sub unequal_triplets( @ints ) {
    my %frequencies;
    ++$frequencies{$_}
        for @ints;

    return 0
	unless %frequencies >= 3;

    # Go through combinations of unique numbers.
    my $combinations = 0;
    my @uniq_ints = sort { $a <=> $b } keys %frequencies;
    for my $i1 ( 0..$#uniq_ints ) {
	for my $i2 ( ( $i1 + 1 ) .. $#uniq_ints ) {
	    for my $i3 ( ( $i2 + 1 ) .. $#uniq_ints ) {
		$combinations +=
		    product( @frequencies{ @uniq_ints[ $i1, $i2, $i3 ] } );
	    }
	}
    }
    return $combinations;
}

run_tests;
