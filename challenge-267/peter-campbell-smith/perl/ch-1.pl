#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-292
use utf8;     # Week 267 - task 1 - Product sign
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

product_sign(-1, -2, -3, -4, 3, 2, 1);
product_sign(-1, -2, -3, 4, 3, 2, 1);
product_sign(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11);

sub product_sign {
	
	my (@ints, $product, $int, $result);
	
	@ints = @_;
	say qq[\nInput:   \@ints = (] . join(', ', @ints) . ')';
	
	# method 1 - simple
	$product = 1;
	$product *= $_ for @ints;
	say qq[Output1: ] . ($product ? $product / abs($product) : 0);
	
	# method 2 - more efficient
	$result = 1;
	for $int (@ints) {
		next if ($int > 0);		
		if ($int == 0) {
			$result = 0;
			last;
		}
		$result = -$result;
	}
	say qq[Output2: $result];
}
