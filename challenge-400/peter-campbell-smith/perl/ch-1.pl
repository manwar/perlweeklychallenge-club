#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/400/1

use v5.26;    # The Weekly Challenge - 2026-11-16
use utf8;     # Week 400 - task 1 - Largest interval
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

largest_interval(110);
largest_interval(1100);
largest_interval(11100);
largest_interval(1000000);

sub largest_interval {
	
	my ($integer, $best_jump, $before, $i, $this_jump, $explain);
	
	# initialise
	$integer = shift;
	$best_jump = 0;
	$before = 1;
	$explain = '';
	
	# loop over possible integers
	for $i (1 .. $integer) {
		
		# skip if repeated digit
		next if $i =~ m|(\d).*\1|;
		
		# inspect this jump
		$this_jump = $i - $before;
		
		# new winner
		if ($this_jump > $best_jump) {
			$explain = qq[$this_jump: [$before, $i]];
			$best_jump = $this_jump
			
		# equal to winner
		} elsif ($this_jump == $best_jump) {
			$explain .= qq[, [$before, $i]];
		}
		$before = $i;
	}
	
	say qq[\nInput:  $integer];
	say qq[Output: jump = $explain];
}
