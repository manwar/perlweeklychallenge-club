#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-08
use utf8;     # Week 351 - task 1 - Special average
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

special_average(8000, 5000, 6000, 2000, 3000, 7000);
special_average(100_000, 80_000, 110_000, 90_000);
special_average(2500, 2500, 2500, 2500);
special_average(1, 3);

sub special_average {
	
	my (@sorted, $sum);
	
	# initialise
	say qq[\nInput:  (] . join(', ', @_) . ')';
	
	# need at lleast 3 elements
	if (@_ > 2) {
		
		# calculate average
		@sorted = sort {$a <=> $b} @_;
		$sum += $sorted[$_] for 1 .. @sorted - 2;
		say qq[Output: ] . ($sum / (@sorted - 2));
	
	# error
	} else {
		say qq[Output: need at least 3 elements];
	}
}

