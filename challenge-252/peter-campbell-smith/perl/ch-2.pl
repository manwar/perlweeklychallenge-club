#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2024-01-15
use utf8;     # Week 252 task 2 - Unique sum zero
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge
binmode STDOUT, ':utf8';

unique_sum_zero(1);
unique_sum_zero(5);
unique_sum_zero(50);

sub unique_sum_zero {
	
	my ($n, $method, $sum, $j, @array, %used);
	
	$n = shift @_;
	say qq[\nInput:  \$n = $n];
	
	# try two ways
	for $method (1 .. 2) {
		@array = ();
		
		# use -n to +n, including 0 in the middle if an odd number
		if ($method == 1) {
			push @array, 0 if $n & 1;
			for $j (1 .. int($n / 2)) {
				push @array, -$j;
				unshift @array, $j
			}
					
		# choose $n - 1 random numbers and add - $sum - unless it has already been used
		} elsif ($method == 2) {
			while (1) {
				$sum = 0;
				@array = ();
				%used = ();
				
				# fill @array with $n - 1 random integers from the range -$n to +$n
				while (@array < $n - 1) {
					$j = int(rand($n * 2)) - $n;
					next if $used{$j};
					$used{$j} = 1;
					push @array, $j;
					$sum += $j;
				}
				
				# add the negated sum unless it has been used already
				push @array, -$sum;
				last unless $used{-$sum};
			}
		}
		
		# show result
		$sum = 0;		
		$sum += $array[$_] for 0 .. $n - 1;
		say qq[Output: (] . join(', ', @array) . qq[), \$sum = $sum];
	}	
}
