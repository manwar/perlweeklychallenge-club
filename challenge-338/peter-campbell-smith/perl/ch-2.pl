#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-08
use utf8;     # Week 338 - task 2 - Max distance
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

max_distance([4, 5, 7], [9, 1, 3, 4]);
max_distance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]);
max_distance([2, 1, 11, 3], [2, 5, 10, 2]);
max_distance([1, 2, 3], [3, 2, 1]);
max_distance([1, 0, 2, 3], [5, 0]);

sub max_distance {
	
	my (@one, @two, $diff1, $diff2);
	
	# initialise
	@one = sort {$a <=> $b} @{$_[0]};
	@two = sort {$a <=> $b} @{$_[1]};
	$diff1 = abs($one[0] - $two[-1]);
	$diff2 = abs($one[-1] - $two[0]);
	
	say qq{\nInput:  [} . join(', ', @{$_[0]}) . '], [' . join(', ', @{$_[1]}) . ']';
	say qq[Output: ] . ($diff1 > $diff2 ? $diff1 : $diff2);
}
