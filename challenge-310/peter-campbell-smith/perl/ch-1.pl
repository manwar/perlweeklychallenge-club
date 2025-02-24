#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-24
use utf8;     # Week 310 - task 1 - Arrays intersection
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

arrays_intersection([1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]);
arrays_intersection([1, 0, 2, 3], [2, 4, 5]);
arrays_intersection([1, 2, 3], [4, 5], [6]);
arrays_intersection([-31, 56, 22, 0, -99], [-31, 56, 100, 423], [-99, 0, 56, -31]);
arrays_intersection([2, 2, 2, 2, 2], [2, 2, 2]);
arrays_intersection([1, 2, 3, 4, 5]);

sub arrays_intersection {
	
	my (@arrays, $value, $missing, $a, $v, @input, @output, @other, $i);
	
	# input
	@arrays = @_;
	$input[$_] = '[' . join(', ', @{$arrays[$_]}) . ']' for 0 .. $#arrays;
	say qq[\nInput:  \@list = (] . join(', ', @input) . ')';
	
	# loop over numbers in first array
	for $value (@{$arrays[0]}) {
		$missing = 0;
	
		# loop over the other arrays
		A: for $a (1 .. $#arrays) {
	
			# loop over values in the other array
			@other = @{$arrays[$a]};
			for $i (0 .. $#other) {
				
				# match - zap it to prevent re-use
				if ($value == $other[$i]) {
					$arrays[$a]->[$i] = 1e6;
					next A;
				}
			}
			
			# no match
			$missing = 1;
		}
		push @output, $value unless $missing;
	}
	say qq[Output: (] . join(', ', sort @output) . ')';
}
