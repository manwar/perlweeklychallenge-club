#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/383/2

use v5.26;    # The Weekly Challenge - 2026-07-20
use utf8;     # Week 383 - task 2 - Nearest rgb
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

nearest_rgb('F4B2D1');
nearest_rgb('15E6E5');
nearest_rgb('191A65');
nearest_rgb('2D5A1B');
nearest_rgb('00FF66');

sub nearest_rgb {
	
	my ($colour, $value, $safe);
	
	# initialise
	$colour = shift;
	
	# loop over 3 components
	while ($colour =~ m|(..)|g) {
		$value = hex($1);
		$value += 25;
		$value = int($value / 51);
		$value = substr('0369CF', $value, 1);
		$safe .= $value . $value;	
	}

	say qq[\nInput:  '$colour'];
	say qq[Output: '$safe'];
}
