#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-12-04
use utf8;     # Week 246 task 1 - 6 out of 49
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

six_from_49();
six_from_49();
six_from_49();
six_from_49();
six_from_49();

sub six_from_49 {
	
	my ($count, $ball, @seen, $result);
	
	# initialise
	$result = qq[Output: ];
	$count = 0;
	
	# find 6 unique 'random' numbers
	while ($count < 6) {
		$ball = int(rand(49)) + 1;
		next if $seen[$ball];
		
		# is unique
		$seen[$ball] = 1;
		$count ++;
		$result .= qq[$ball, ];	
	}
	
	# show result
	say substr($result, 0, -2);
}
