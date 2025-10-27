#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-27
use utf8;     # Week 345 - task 1 - Peak positions
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

peak_positions(1, 2, 3, 2, 1);
peak_positions(1, 2, 3, 4, 5);
peak_positions(3, 3, 3, 3, 3);
peak_positions(3, 2, 1, 2, 3);
peak_positions(1, 2, 1, 3, 1, 4, 1, 6, 1);
peak_positions(1, 2);
peak_positions(-3, -2, -4, 0, 9, -100);

sub peak_positions {
	
	my (@ints, @peaks, $j);
	
	# initialise
	@ints = @_;
	
	# do as instructed
	if ($#ints > 2) {
		for $j (1 .. $#ints - 1) {
			push @peaks, $j if ($ints[$j] > $ints[$j - 1]
				and $ints[$j] > $ints[$j + 1]);
		}
	}
		
	say qq[\nInput:  (] . join(', ', @ints) . ')';
	say qq[Output: (] . join(', ', @peaks) . ')';
}
