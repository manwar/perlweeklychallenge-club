#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-27

use v5.28;
use utf8;
use warnings;

# Task: You are given an array of integers having even number of elements. Divide the array into
# all possible pairs of elements. Write a script to find the two pairs whose minima sum to the
# maximum value.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/206/1


max_min(1, 2, 3, 4);
max_min(0, 2, 1, 3);
max_min(3, 7, 4, 12, 5, 1, 0, 10, 9, 2, 11, 13, -1, 6, 2);

sub max_min {
	
	# reverse sort the array numerically
	my @array = reverse sort { $a <=> $b} @_;
	
	# show the results (see blog for explanation)
	say qq[\nInput:  \@array = (] . join(', ', @_) . qq[)];
	say qq[Output: ] . ($array[1] + $array[3]) . 
		qq[ = min($array[0], $array[1]) + min($array[2], $array[3])];
}
	
	

