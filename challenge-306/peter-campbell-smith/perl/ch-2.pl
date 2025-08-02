#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-27
use utf8;     # Week 306 - task 2 - Last element
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

last_element(3, 8, 5, 2, 9, 2);
last_element(3, 2, 5);
last_element(43, 21, 56, 86, 2, 69, 10, 43, 77, 30);

sub last_element {
	
	my (@ints, $x);
	
	# initialise
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	
	# loop until 0 or 1 element left
	while ($#ints > 0) {
		@ints = sort {$b <=> $a} @ints;
		
		# if x == y
		if ($ints[0] == $ints[1]) {
			shift @ints; 
			shift @ints;
		
		# if x != y
		} else {
			$x = shift @ints;
			$ints[0] = $x - $ints[0];
		}
	}
	say qq[Output: ] . ($ints[0] or 0);
}
