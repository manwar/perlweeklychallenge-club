#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-05
use utf8;     # Week 320 - task 2 - Sum difference
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

sum_difference(1, 23, 4, 5);
sum_difference(1, 2, 3, 4, 5);
sum_difference(1, 2, 34);

# larger example
my @nums;
push @nums, int(rand(1000)) for 0 .. 99;
sum_difference(@nums);

sub sum_difference {
	
	my (@integers, $elements, $digits);
	@integers = @_;
	
	# make the desired sums
	$elements += $_ for @integers;
	$digits = eval(join('+', split('', join('', @integers))));
	
	say qq[\nInput:  (] . join(', ', @integers) . q[)];
	say qq[Output: ] . ($elements - $digits) . qq[ (elements = $elements, digits = $digits)];
}
