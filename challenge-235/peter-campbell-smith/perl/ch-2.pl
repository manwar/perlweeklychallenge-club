#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-18
use utf8;     # Week 235 task 2 - Duplicate zeroes
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

duplicate_zeroes(1, 0, 2, 3, 0, 4, 5, 0);
duplicate_zeroes(1, 2, 3);
duplicate_zeroes(0, 3, 0, 4, 5);
duplicate_zeroes(0, 0, 0, 0, 1, 2, 3, 4);
duplicate_zeroes(1, 2, 3, 4, 5, 0);

sub duplicate_zeroes {
	
	my (@ints, $j, @new);
	
	# initialise
	@ints = @_;
	
	# push items from @ints onto @new, doubling every 0
	push @new, ($_ == 0 ? (0, 0) : $_) for @ints;
	
	# cut back @new to the length of @ints
	@new = @new[0 .. scalar @ints - 1];
	
	# show results
	say qq[\nInput:  \@ints = (] . join(qq[, ], @ints) . q[)];
	say qq[Output:         (] . join(qq[, ], @new) . q[)];;
}
