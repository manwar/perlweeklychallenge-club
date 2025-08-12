#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-11
use utf8;     # Week 334 - task 2 - Nearest valid point
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

nearest_valid_point(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]);
nearest_valid_point(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]);
nearest_valid_point(1, 1, [[2, 2], [3, 3], [4, 4]]);
nearest_valid_point(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]);
nearest_valid_point(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]);

sub nearest_valid_point {
	
	my ($x, $y, $px, $py, $point, $points, $best, $mhd, $winner, $point_list, $index);
	
	# initialise
	($x, $y, $points) = @_;
	$best = 1e10;
	
	# loop over points
	for $index (0 .. scalar(@$points) - 1) {
		($px, $py) = @{$points->[$index]};
		$point_list .= qq{[$px, $py], }; 
		
		# check validity
		if    ($px == $x) { $mhd = abs($py - $y) }
		elsif ($py == $y) { $mhd = abs($px - $x) }
		else 			  { next }	
		
		# is this the winner?
		if ($mhd < $best) {
			$best = $mhd;
			$winner = qq{index = $index, coords = [$px, $py], distance = $mhd};
		}
	}
	
	say qq[\nInput:  \$x = $x, \$y = $y, \@points = ] . substr($point_list, 0, -2);
	say qq[Output: ] . (defined($winner) ? $winner : '-1');
}
