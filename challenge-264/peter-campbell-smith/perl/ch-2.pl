#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-08
use utf8;     # Week 264 - task 2 - Target array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]);
target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]);
target_array([1], [0]);
target_array([0, 1, 2, 3, 4], [3, 0, 4, 3, 2]);
target_array([11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [9, 4, 2, 7, 5, 8, 1, 0, 3, 6]);
target_array([11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

sub target_array {
	
	my (@source, @indices, @target, $i, $j, $k, $hold, $value);
	
	@source = @{$_[0]};
	@indices = @{$_[1]};
	
	# loop over indices
	for $i (0 .. @indices - 1) {
		$j = $indices[$i];
		$value = $target[$j];
		
		# if the place in @target is occupied, move it and subsequent ones right
		$k = $j;
		while (defined $value) {
			$hold = $target[$k];
			$target[$k] = $value;
			$value = $hold;
			$k ++;
		}
		$target[$j] = $source[$i];
	}
	
	# show results (with '?' for undefined - see analysis)
	for ($j = 0; $j < @target; $j ++) {
		$target[$j] = '?' unless defined $target[$j];
	}
	
	say qq[\nInput:  \@source  = (] . join(', ', @source) . ')';
	say qq[        \@indices = (] . join(', ', @indices) . ')';
	say qq[Output:            (] . join(', ', @target) . ')';
}
