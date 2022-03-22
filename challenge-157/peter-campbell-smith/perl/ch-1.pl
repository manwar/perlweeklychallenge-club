#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-22
# PWC 157 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to compute all three Pythagorean Means i.e Arithmetic Mean, Geometric 
# Mean and Harmonic Mean of a given set of integers.

# This is the vanilla way to do it: someone will have the strawberry version using imported modules
# or one line solutions.

# Blog: https://pjcs-pwc.blogspot.com/2022/03/mean-brazilians.html

my ($sum, $n, $product, $reciprocals, @examples, $example, $string);

# given sets of integers
@examples = ([1, 3, 5, 6, 9], [2, 4, 6, 8, 10], [1, 2, 3, 4, 5], [73, 201, 1, 99, 123, 14, 83, 46, 77]);

# loop over sets
for $example (@examples) {
	
	# get started
	$product = 1;
	$sum = $reciprocals = 0;
	$string = '';
	
	# form sum, product and sum of reciprocals
	for $n (@$example) {
		$sum += $n;
		$product *= $n;
		$reciprocals += 1 / $n;
		$string .= qq[$n, ];
	}
	
	# and tell the world
	say qq[\nInput:  \@n = (] . substr($string, 0, -2) . qq[)\nOutput: ] .
		qq[AM = ] .   sprintf('%1.1f', ($sum / scalar @$example)) .
		qq[, GM = ] . sprintf('%1.1f', ($product ** (1 / scalar @$example))) .
		qq[, HM = ] . sprintf('%1.1f', (scalar @$example / $reciprocals));
}

