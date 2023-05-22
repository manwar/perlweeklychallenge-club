#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-15
use utf8;     # Week 216 task 1 - Sorted matrix
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

sorted_matrix([3, 1, 2], [5, 2, 4], [0, 1, 3]);
sorted_matrix([2, 1], [4, 5]);
sorted_matrix([1, 0, 3], [0, 0, 0], [1, 2, 1]);
sorted_matrix([1, 2, 3, 4, 5], [3, 4, 5, 6, 7], [9, 8, 7, 6, 5], [0, 2, 4, 6, 8], [9, 7, 5, 3, 1]);

sub sorted_matrix {
	
	my (@list, @rows, $j);

	# concatenate rows and then sort the list
	push @list, @$_ for @_;
	@list = sort { $a <=> $b } @list;
	
	# show results
	$rows[$j ++] = '[' . join(', ', @$_) . ']' for @_;
	say qq[\nInput:  \@matrix = (] . join(', ', @rows) . ')';
	say qq[Output: $list[2]];
}
