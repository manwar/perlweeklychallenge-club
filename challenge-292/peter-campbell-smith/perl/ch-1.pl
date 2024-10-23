#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-21
use utf8;     # Week 292 - task 1 - Twice largest
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

twice_largest(1, 2, 3, 4);
twice_largest(2, 4, 1, 0);
twice_largest(1, 2, 8, 3, 4);
twice_largest(3, 8, 7, 5, 1, 0, 9, 3, 17, 7, 5, 6, 2, 4, 9, 6, 2);
twice_largest(3, 8, 7, 5, 1, 0, 9, 3, 18, 7, 5, 6, 2, 4, 9, 6, 2);
twice_largest(3, 8, 7, 5, 1, 0, 9, 3, 19, 7, 5, 6, 2, 4, 9, 6, 2);

sub twice_largest {
	
	my (@ints, @sorted, $result, $i);
	
	# initialise
	@ints = @_;
	@sorted = sort { $a<=>$b } @ints;
	$result = -1;

	# check if largest >= 2nd largest
	if ($sorted[$#ints] >= 2 * $sorted[$#ints - 1]) {
		
		# it is, so find its index
		$result = 0;
		$result ++ while $ints[$result] != $sorted[$#ints];
	}
	
	# say results
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: $result];
}
