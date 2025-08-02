#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-19
use utf8;     # Week 283 - task 2 - Digit count value
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

digit_count_value(1, 2, 1, 0);
digit_count_value(0, 3, 0);
digit_count_value(1, 2, 3, 2, 1, 0);

sub digit_count_value {
	
	my (@ints, %freq, $i, $result);
	
	# calculate frequency of each occurring element
	@ints = @_;
	$freq{$_} ++ for @ints;
	
	# test the challenge assertion
	$result = 'true';
	for $i (0 .. @ints - 1) {
		
		# zero is allowed
		$freq{$i} = 0 unless defined $freq{$i};
		
		# quit unless assertion is true
		if ($ints[$i] != $freq{$i}) {
			$result = qq[false ∵ \$ints[$i] = $ints[$i] and $i occurs $freq{$i} times];
			last;
		}
	}
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: $result];
}
