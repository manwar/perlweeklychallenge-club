#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-02-26
use utf8;     # Week 258 - task 2 - Sum of values
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

sum_of_values([2, 5, 9, 11, 3], 1);
sum_of_values([2, 5, 9, 11, 3], 2);
sum_of_values([2, 5, 9, 11, 3], 0);
sum_of_values([2, 5, 9, 11, 3], 3);
sum_of_values([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 4);

sub sum_of_values {
	
	my (@ints, $k, $j, $sum, $binary, $bit_count, $explain);
	
	# initialise
	@ints = @{$_[0]};
	$k = $_[1];
	$sum = 0;
	$explain = '';
	
	# loop over @ints
	for $j (0 .. @ints - 1) {
		
		# count bits in index
		$binary = sprintf('%b', $j);
		$bit_count = eval(join('+', split('', $binary)));
		
		# accumulate $sum where $j has $k bits set
		next unless $bit_count == $k;
		$sum += $ints[$j];
		$explain .= qq[$j == 0b$binary, ];
	}
	
	# show results
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[), \$k = $k];
	say qq[Output: $sum] . 
		($explain ?  ' ∵ ' . substr($explain, 0, -2) : '');
}
