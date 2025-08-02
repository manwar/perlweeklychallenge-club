#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-10
use utf8;     # Week 312 - task 2 - Balls and boxes
use warnings; # Peter Campbell Smith
no warnings 'uninitialized';
binmode STDOUT, ':utf8';

balls_and_boxes('G0B1R2R0B0');
balls_and_boxes('G1R3R6B3G6B1B6R1G3');
balls_and_boxes('B3B2G1B3');

sub balls_and_boxes {
	
	my (%colours, $string, @box, $count);
	
	# initialise
	$string = shift;
	%colours = (R => 1, G => 2, B => 4);

	# count which colours seen
	$box[$2] |= $colours{$1} while $string =~ m|(.)(\d+)|g;
	
	# count full boxes
	$count = $count + ($_ == 7 ? 1 : 0) for @box;	
	
	say qq[\nInput:  \$string = '$string'];
	say qq[Output: ] . ($count + 0);
}
