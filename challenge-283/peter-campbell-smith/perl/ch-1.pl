#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-19
use utf8;     # Week 283 - task 1 - Unique number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

unique_number(1, 1, 2, 3, 4, 5, 3, 4, 5);
unique_number(3, 2, 4, 2, 4);
unique_number(7);
unique_number(4, 3, 1, 1, 4);
unique_number(123, 456, 77, 9999, 55, 55, 9999, 77, 456);

sub unique_number {
	
	my (@ints, %freq, $j);
	
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	
	# count occurrences of each number
	$freq{$_} ++ for @ints;
	
	# find the (first) one that only occurs once
	for $j (keys %freq) {
		if ($freq{$j} == 1) {
			say qq[Output: $j];
			return;
		}
	}
	
	# none occurs once
	say qq[Output: none];
}
