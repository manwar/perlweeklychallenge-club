#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-16
use utf8;     # Week 300 - task 2 - Nested array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

nested_array([5, 4, 0, 3, 1, 6, 2]);
nested_array([1, 0,  4, 2, 3,  8, 10, 7, 9, 6, 5]);
nested_array([0, 1, 2, 3, 4, 5]);
nested_array([0, 2, 1]);

sub nested_array {
	
	my (@ints, $s, $loop, $t, $length, $longest, $best, @seen);
	
	#initialise
	@ints = @{$_[0]};
	$longest = 0;
	
	# find a new loop starting at $s 
	for $s (0 .. $#ints) {
		next if defined $seen[$s];
		
		# start the loop here
		$loop = qq[$s, ];
		$t = $s;
		
		# follow the loop till it gets back to the start
		do {
			$t = $ints[$t];
			$loop .= qq[$t, ];
			$seen[$t] = 1;
		} until ($t == $s);
		
		# see if it's the longest
		$length = ($loop =~ s|,|,|g) - 1;
		if ($length > $longest) {
			$longest = $length;
			$best = $loop;
		}
	}
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: $longest - (] . substr($best, 0, -2) . ')';
}
