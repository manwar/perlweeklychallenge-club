#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-22
use utf8;     # Week 340 - task 2 - Ascending numbers
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

ascending_numbers('the 1 cat sat on the 2 mats');
ascending_numbers('the 2 cats sat on the 1 mat');
ascending_numbers('the 3 cats sat on the 3 mats');
ascending_numbers('one 1 two 2 three 3 four 4 five six 5 6 oops 5');
ascending_numbers('0');
ascending_numbers('cat');

sub ascending_numbers {
	
	my ($string, $last);
	
	# initialise
	$string = $_[0];
	say qq[\nInput:  '$string'];
	$last = -1;
	
	# loop over numbers
	while ($string =~ m|(\d+)|g) {
		
		# ok
		if ($1 > $last) {
			$last = $1;
			next;
		}
		
		# not ok
		say qq[Output: false ($1)];
		return;
	}
	say qq[Output: true];
}
