#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-12
use utf8;     # Week 221 task 2 - Arithmetic subsequence
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($j, @ints);

arithmetic_subsequence(9, 4, 7, 2, 10, 12, 13);
arithmetic_subsequence(2, 7, -1, 9, -4, 11, -7, 33, -10);
arithmetic_subsequence(3, 3, 3);
arithmetic_subsequence(1, 2, 4, 7, 11, 16);
arithmetic_subsequence(2, 4, 6, 8, 21, 22, 23, 24);
arithmetic_subsequence(1, 2, 7, 19, 44, 123);
arithmetic_subsequence(1, 2);
arithmetic_subsequence(1, 2, 'x');

# larger example
for $j (0 .. 99) {
	push (@ints, int(rand(50)));
}
arithmetic_subsequence(@ints);

sub arithmetic_subsequence {
	
	my (@ints, $best, $last, $first, $second, $next, $length, $target, $explain, $best_explain, $delta);
	
	# initialise
	@ints = @_;
	return unless validate(@ints);
	$best = 0;
	$last = scalar @ints - 1;
	
	# loop over all possible first and second members of a subsequence
	for $first (0 .. $last - 2) {
		for $second ($first + 1 .. $last - 1) {
			
			# see how many subsequent members exist
			$delta = $ints[$second] - $ints[$first];
			$length = 2;
			$target = $ints[$second] + $delta;
			$explain = qq[($ints[$first], $ints[$second], ];
			
			# loop over rest of @ints to find them
			for $next ($second + 1 .. $last) {
				if ($ints[$next] == $target) {
					$length ++;
					$target += $delta;
					$explain .= qq[$ints[$next], ];
				}
			}
			
			# new or new equal longest length found
			$explain = substr($explain, 0, -2) . '), ';
			if ($length > $best) {
				$best = $length;
				$best_explain = $explain;
			} elsif ($length == $best) {
				$best_explain .= $explain unless $best_explain =~ m|\Q$explain|;
			}
		}
	}
	
	# give verdict
	say qq[\nInput:  (] . join(', ', @ints) . ')';
	say qq[Output: ] . ($best > 2 ? qq[$best: ] . substr($best_explain, 0, -2) : q[No arithmetic subsequences]);
}

sub validate {
	
	my (@ints, $j, $error);
				
	# check input is valid
	@ints = @_;
	
	# must have >= 3 in @ints
	$error = qq[need at least 3 integers] if scalar @ints < 3;
	
	# must be integers
	for $j (@ints) {
		$error = qq[$j is not an integer] unless $j =~ m|^-?\d+$|;
	}
	return 1 unless $error;
	say qq[\nInput:  (] . join(', ', @ints) . qq[)\nOutput: Invalid input - $error];
	return 0;
}