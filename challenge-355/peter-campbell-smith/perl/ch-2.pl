#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-05
use utf8;     # Week 355 - task 2 - Mountain array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

mountain_array(1, 2, 3, 4, 5);       # no down steps
mountain_array(0, 2, 4, 6, 4, 2, 0); # good
mountain_array(5, 4, 3, 2, 1);       # no up steps
mountain_array(1, 3, 2);             # minimal good
mountain_array(1, 3, 5, 5, 4, 2);    # repeated up step
mountain_array(1, 2, 3, 2, 1, 1);    # repeated down step
mountain_array(1, 1, 2, 3, 2, 1);    # repeated up step

sub mountain_array {
	
	my (@height, $going, $result, $j);
	
	# initialise
	@height = @_;
	$going = 'up';
	$result = 'true';
	
	# start climbing
	STEP: for $j (1 .. $#height) {
		if ($going eq 'up') {
			
			# next step is up - good
			if ($height[$j] > $height[$j - 1]) {

			# next step is level or first step isn't up
			} elsif ($height[$j] == $height[$j - 1] or $j == 1) {
				$result = 'false';
				last STEP;
				
			# reached the summit
			} else {
				$going = 'down';
			}
		
		# going down
		} else {
			
			# next step isn't downward
			if ($height[$j] >= $height[$j - 1]) {
				$result = 'false';
				last STEP;
			}
		}	
	}
	
	# report
	say qq[\nInput:  (] . join(', ', @height) . ')';
	say qq[Output: ] . ($going eq 'down' ? $result : 'false');
}
