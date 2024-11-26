#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-25
use utf8;     # Week 297 - task 1 - Contiguous array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

# You are given an array of binary numbers, @binary.
# Write a script to return the maximum length of a contiguous subarray with an equal number of 0 and 1.

# length cannot exceed the smaller of no of 0s and no of 1s

contiguous_array(1, 0, 1, 0, 0, 0, 1, 1);
contiguous_array(1, 1, 1, 0, 1, 1, 1, 0, 1);
contiguous_array(1, 1, 1, 1, 1);
contiguous_array(1, 0, 1, 0, 1, 0, 1, 0, 1);
contiguous_array(1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1);
contiguous_array(1, 0, 0);
contiguous_array(1, 1, 1, 1, 1, 0, 0, 0, 0, 0);

my @ints;
push @ints, int(rand(2)) for 0 .. 200;
contiguous_array(@ints);

sub contiguous_array {
	
	my (@binary, $longest, $start, $sum, $end, $length, $location);
	
	# initialise
	@binary = @_;
	$longest = 0;
	
	# loop over starting element
	START: for $start (0 .. $#binary - 1) {
		$sum = 0;
		
		# loop over ending element
		for ($end = $start + 1; $end <= $#binary; $end += 2) {
			$sum += ($binary[$end - 1] ? -1 : 1) + ($binary[$end] ? -1 : 1);
			
			# give up on this start if no hope
			next START if $sum > $end - $start + 1;
			
			# save result if best-so-far equal numbers of 0s and 1s
			if ($sum == 0) {
				$length = $end - $start + 1;
				if ($length > $longest) {
					$longest = $length;
					$location = qq[$start to $end];
				}
			}
		}
	}

	# report
	say qq[\nInput:  \@binary = (] . join(', ', @binary) . ')';
	say qq[Output: $longest] . ($location ? qq[ ($location)] : '');
}
