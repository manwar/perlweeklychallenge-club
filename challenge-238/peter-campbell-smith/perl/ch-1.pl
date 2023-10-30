#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-09
use utf8;     # Week 237 task 1 - Running sum
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

running_sum(1, 2, 3, 4, 5);
running_sum(1, 1, 1, 1, 1);
running_sum(0, -1, 1, 2);
running_sum(34, 65, 12, -98, 87, 44, 72, 0, 39, 92);

sub running_sum {
	
	my (@ints, $j, @sums);
	
	@ints = @_;
	say qq[\nInput:  \@ints = (], join(', ', @ints) . ')';
	
	for $j (1 .. @ints - 1) {
		$ints[$j] = $ints[$j - 1] + $ints[$j];
	}
	
	say qq[Output:         (] . join(', ', @ints) . ')';
}
	