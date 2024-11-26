#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-25
use utf8;     # Week 297 - task 2 - Semi-ordered permutation
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

semiordered_permutation(2, 4, 6, 8, 1, 3, 5, 7);
semiordered_permutation(7, 5, 3, 1, 8, 6, 4, 2);
semiordered_permutation(1, 2, 3, 4, 5, 6, 7, 8);
semiordered_permutation(8, 7, 6, 5, 4, 3, 2, 1);

sub semiordered_permutation {
	
	my (@ints, $z, $smallest, $largest, $j, $smallest_j, $largest_j, $swaps);
	
	# find the indices of smallest and largest integers
	@ints = @_;
	$smallest = 1e6;
	$largest = -1e6;
	$z = @ints - 1;
	for $j (0 .. $z) {
		if ($ints[$j] < $smallest) {
			$smallest = $ints[$j];
			$smallest_j = $j;
		}
		if ($ints[$j] > $largest) {
			$largest = $ints[$j];
			$largest_j = $j;
		}
	}
	
	# calculate answer (see blog)
	$swaps = $smallest_j + $z - $largest_j;
	$swaps -= 1 if $smallest_j > $largest_j;
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: $swaps];
}
