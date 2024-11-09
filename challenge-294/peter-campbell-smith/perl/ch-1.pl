#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-04
use utf8;     # Week 294 - task 1 - Consecutive sequence
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

consecutive_sequence(0, 10, 1, 12, 14, 2, 4, 3, 1, 16);
consecutive_sequence(10, 4, 20, 1, 3, 2);
consecutive_sequence(10, 30, 20);
consecutive_sequence(1000000, 1000001, 1000002, 42);
consecutive_sequence(1, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5, 7);
consecutive_sequence(1, 7, 3, 6, 2, 9, 11, 4);

sub consecutive_sequence {
	
	my (@ints, @seen, $sequence, $best, $end, $j, $this, $run);
	
	# create $seen[$j] = 1 for all $j in @ints
	@ints = @_;
	$seen[$_] = 1 for @ints;
	
	# loop over %seen
	$sequence = $best = 0;
	$end = -1;
	for $j (1 .. $#seen) {
		unless (defined $seen[$j]) {
			$sequence = 0;
			next;
		}
			
		# if consecutive elements of @seen exist, we have a sequence
		if (defined $seen[$j - 1]) {
			$sequence ++;
			if ($sequence > $best) {
				$best = $sequence;
				$end = $j;
			}
		}
	}
	
	# show results
	$run .= qq[$_, ] for ($end - $best) .. $end;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say '' . ($end > 0) ?
		sprintf ('%s %d: (%s)', 'Output:', $best + 1, substr($run, 0, -2)) :
		qq[Output: -1];
}
