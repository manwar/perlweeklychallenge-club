#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-02-19
use utf8;     # Week 257 - task 1 - Smaller than current
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

smaller_than_current(5, 2, 1, 6);
smaller_than_current(1, 2, 0, 3);
smaller_than_current(158, 183, 309, 369, 314, 461, 235, 
464, 474, 116, 432, 323, 287, 445, 444, 345, 86, 218, 261, 
386, 470, 292, 91, 86, 472, 242, 134, 316, 244, 369, 288, 
207, 237, 406, 449, 377, 464, 346, 175, 302, 464, 27, 276, 
268, 409, 199, 206, 201, 106, 225, 323, 148, 306, 104, 
481, 1, 476, 143, 147, 206, 50, 97, 379, 478, 380, 73, 
321, 122, 290, 489, 120, 351, 175, 318, 448, 357, 44, 46, 
458, 259, 409, 313, 341, 118, 461, 358, 222, 336, 371, 
296, 72, 478, 286, 97, 137, 167, 163, 264, 169, 74, 386, 
82, 70, 478, 447, 6, 235, 451, 84);

sub smaller_than_current {
	
	my (@ints, $i, $j, @smaller);
	
	@ints = @_;
	
	# calculate result for $ints[$j]
	for $i (0 .. scalar @ints - 1) {
		$smaller[$i] = 0;
		
		# count all numbers less than $ints[$j]
		for $j (0 .. scalar @ints - 1) {
			$smaller[$i] ++ if $ints[$j] < $ints[$i];
		}
	}
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . q[)];
	say qq[Output:         (] . join(', ', @smaller) . q[)];
}
