#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-08
use utf8;     # Week 351 - task 2 - Arithmetic progression
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

arithmetic_progression(9, 1, 7, 5, 3);
arithmetic_progression(-1, -2, -3, -4);
arithmetic_progression(-4, -3, -2, -1);
arithmetic_progression(1e6, 3e6, 5e6, 7e6, 9e6);
arithmetic_progression(111);
arithmetic_progression(111, 222);
arithmetic_progression(111, 222, 333);
arithmetic_progression(11/7, 14/7, 17/7, 29/7);

sub arithmetic_progression {
	
	my (@sorted, $increment, $j);
	
	# initialise
	say qq[\nInput:  (] . join(', ', @_) . ')';
	
	# need at lleast 3 elements
	if (@_ < 3) {
		say qq[Output: indeterminate - array too short];
		return;
	}
		
	# check for arithmetic progression
	@sorted = sort {$a <=> $b} @_;
	$increment = $sorted[1] - $sorted[0];
	
	for $j (1 .. @sorted - 2) {
		next if $sorted[$j + 1] = $sorted[$j] + $increment;
		say qq[Output: false as $sorted[$j + 1] - $sorted[$j] != $increment];
		return;
	}
	say qq[Output: true with increment of $increment];

}
