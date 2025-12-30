#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-29
use utf8;     # Week 354 - task 1 - Min abs diff
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

min_abs_diff(4, 2, 1, 3);
min_abs_diff(10, 100, 20, 30);
min_abs_diff(-5, -2, 0, 3);
min_abs_diff(8, 1, 15, 3);
min_abs_diff(12, 5, 9, 1, 15);

sub min_abs_diff {
	
	my (@sorted, $j, $least, $diff, $result);
	
	# initialise and sort
	@sorted = sort {$a <=> $b} @_;
	$least = ~1e10;
	
	# loop over numbers
	for $j (0 .. $#sorted - 1) {
		$diff = $sorted[$j + 1] - $sorted[$j];
		
		# not the best
		next if $diff > $least;
		
		# new best
		if ($diff < $least) {
			$result = '';
			$least = $diff;
		}
		
		# new best or equal to previous best
		$result .= qq[[$sorted[$j], $sorted[$j + 1]], ];
	}
		
	say qq[\nInput:  (] . join(', ', @_) . ')';
	say qq[Output: ] . substr($result, 0, -2);
}
