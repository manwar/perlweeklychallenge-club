#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2024-01-01
use utf8;     # Week 250 task 1 - Smallest index
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

binmode STDOUT, ':utf8';

smallest_index(4, 3, 2, 1);
smallest_index(2, 4, 6, 7, 3, 9, 1, 0, 2, 4, 7, 8, 2, 3);
smallest_index(1, 2, 3, 4, 5, 6, 7, 8, 9, 0);

sub smallest_index {
	
	my (@ints, $i, $i_mod10);
	
	#initialise
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	
	# loop over supplied values
	for $i (0 .. @ints - 1) {
		$i_mod10 = $i % 10;
		
		# apply stated rule
		if ($i_mod10 == $ints[$i]) {
			say qq[Output: $i ∵ \$i = $i, \$i mod 10 = $i_mod10, \$ints[$i] = $ints[$i]];
			return;
		}
	}
	say qq[Output:  -1];
}
		