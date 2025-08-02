#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-02
use utf8;     # Week 298 - task 2 - Right interval
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

right_interval([3, 4], [2, 3], [1, 2]);
right_interval([1, 2]);
right_interval([1, 4], [2, 2], [3, 4]);
right_interval([1, 1], [12, 12], [23, 23], [34, 34]);
right_interval([9, 9], [8, 8], [7, 7], [6, 6]);

sub right_interval {
	
	my (@ints, $i, $j, @right_int, $input, $best, $best_j);
	@ints = @_;
	
	# loop over intervals
	I: for ($i = 0; $i <= $#ints; $i ++) {
		
		# loop over each potential right intervals
		$best = $best_j = 1e6;
		for ($j = 0; $j <= $#ints; $j ++) {
			if ($ints[$j]->[0] >= $ints[$i]->[1]) {
				
				# save the least
				if ($ints[$j]->[0] < $best) {
					$best = $ints[$j]->[0];
					$best_j = $j;
				}
			}
		}
		$right_int[$i] = $best_j < 1e6 ? $best_j : -1;
	}

	# report results
	$input .= qq{[$ints[$_]->[0], $ints[$_]->[1]], } for 0 .. $#ints;
	say qq[\nInput:  \@intervals = ] . substr($input, 0, -2);
	say qq[Output: ] . join(', ', @right_int);
}
