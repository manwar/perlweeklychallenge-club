#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-15
use utf8;     # Week 339 - task 2 - Peak point
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

peak_point(-5, 1, 5, -9, 2);
peak_point(10, 10, 10, -25);
peak_point(3, -4, 2, 5, -6, 1);
peak_point(-1, -2, -3, -4);
peak_point(-10, 15, 5);

my @steps;
push @steps, int(rand(21)) - 10 for 1 .. 100; 
peak_point(@steps);

sub peak_point {
	
	my ($height, $highest, $climb);
	
	# initialise
	$height = 0;
	$highest = 0;
	
	# start climbing
	for $climb (@_) {
		$height += $climb;
		$highest = $height if $height > $highest;
	}
	
	say qq[\nInput:  (] . join(', ', @_) . ')';
	say qq[Output: $highest];
}
