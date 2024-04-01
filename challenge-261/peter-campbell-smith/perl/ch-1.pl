#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-18
use utf8;     # Week 261 - task 1 - Element digit sum
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@ints, $j);

element_digit_sum(1, 2, 3, 45);
element_digit_sum(1, 12, 3);
element_digit_sum(1, 2, 3, 4);
element_digit_sum(236, 416, 336, 350);

# longer random example
for $j (0 .. 49) {
	$ints[$j] = int(rand(1000));
}
element_digit_sum(@ints);

sub element_digit_sum {
	
	my (@ints, $digit_sum, $element_sum, $difference);
	
	# calculate sums
	@ints = @_;
	$element_sum += $_ for @ints;
	$digit_sum += $_ for split('', join('', @ints));
	
	# calculate difference
	$difference = abs($element_sum - $digit_sum);
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[)\n] .
		qq[Output: $difference (element sum = $element_sum, digit sum = $digit_sum)];
}
