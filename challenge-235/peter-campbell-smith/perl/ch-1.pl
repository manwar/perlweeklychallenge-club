#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-18
use utf8;     # Week 235 task 1 - Remove one
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

remove_one(1, 2, 3, 4, 5);
remove_one(5, 4, 3, 2, 1);
remove_one(9, 2, 3, 4, 5);
remove_one(1, 2, 3, 4, 0);
remove_one(1, 2, 0, 4, 5);
remove_one(1, 2, 9, 4, 5);

sub remove_one {
	
	my (@ints, $result, $remove, $last, $j, $break);
	
	# initialise
	@ints = @_;
	$result = 'false';
	$last = scalar @ints - 1;
	
	# must have at least 3 elements
	if ($last >= 2) {
		
		# loop over elements
		J: for $j (1 .. $last) {
			
			# do nothing if this element > previous element
			next J if $ints[$j] > $ints[$j - 1];

			# if this is a second break then no hope
			if (defined $break) {
				$result = 'false';
				last J;
			}
			
			# so this is a first break
			$break = $j;
			
			# if this is the first or last element then we can remove that
			if ($j == 1) {
				$result = 'true';
				$remove = 0;
				
			} elsif ($j == $last) {
				$result = 'true';
				$remove = $last;
			
			# will removing $j work?
			} elsif ($ints[$j - 1] < $ints[$j + 1]) {
				$result = 'true';
				$remove = $j;
				
			# ... or $j - 1?
			} elsif ($ints[$j - 2] < $ints[$j - 1]) {
				$result = 'true';
				$remove = $j - 1;
			}
		}
		
		# if the sequence is already monotonically increasing then we can remove any element
		unless (defined $break) {
			$result = 'true';
			$remove = 0;
		}
	}
	say qq[\nInput: \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: $result] . ($result eq 'true' ? qq[ (remove $ints[$remove])] : '');
}
