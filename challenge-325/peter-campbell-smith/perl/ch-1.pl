#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-09
use utf8;     # Week 325 - task 1 - Consecutive ones
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

consecutive_ones(0, 1, 1, 0, 1, 1, 1);
consecutive_ones(0, 0, 0, 0);
consecutive_ones(1, 0, 1, 0, 1, 1);

# bigger example
my @array;
push @array, int(rand($_)) & 1 for 0 .. 100;
consecutive_ones(@array);

sub consecutive_ones {
	
	my(@array, $this_run, $max_run, $j);
	
	# initialise
	@array = @_;
	push @array, 0;
	$max_run = $this_run = 0;
	
	# explore array
	for $j (@array) {
		
		# it's a 1
		if ($j) {
			$this_run ++;
			$max_run = $this_run if $this_run > $max_run;
			
		# it's a 0
		} else {
			$this_run = 0;
		}
	}

	say qq[\nInput:  (] . join(', ', @array[0 .. $#array - 1]) . q[)];
	say qq[Output: $max_run];
}
