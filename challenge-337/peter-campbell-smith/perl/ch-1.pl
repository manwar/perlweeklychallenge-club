#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-01
use utf8;     # Week 337 - task 1 - Smaller than current
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

smaller_than_current(6, 5, 4, 8);
smaller_than_current(7, 7, 7, 7);
smaller_than_current(5, 4, 3, 2, 1);
smaller_than_current(-1, 0, 3, -2, 1);
smaller_than_current(0, 1, 1, 2, 0);

sub smaller_than_current {
	
	my (@input, @output, $j);
	
	# initialise
	@input = @_;
	
	# count elements smaller than this one
	for $j (0 .. $#input) {
		$output[$j] = 0;
		$output[$j] ++ for grep { $_ < $input[$j] } @input;
	}
	
	say qq[\nInput:  (] . join(', ', @input) . ')';
	say qq[Output: (] . join(', ', @output) . ')'
}
