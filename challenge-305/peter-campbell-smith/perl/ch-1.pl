#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-01-20
use utf8;     # Week 305 - task 1 - Binary prefix
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Math::Prime::Util 'is_prime';

binary_prefix(1, 1, 0);
binary_prefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1);
binary_prefix(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
binary_prefix(0, 1);

sub binary_prefix {
	
	my (@binary, $sum, $j, $result);
	
	@binary = @_;
	$sum = 0;
	
	# loop over entries in @binary
	for $j (0 .. $#binary) {
		
		# shift $sum left one bit and add next bit
		$sum = 2 * $sum + $binary[$j];
		$result .= is_prime($sum) ? 'true, ' : 'false, '
	}
	
	say qq[\nInput:  \@binary = (] . join(', ', @binary) . ')';
	say qq[Output: (] . substr($result, 0, -2) . ')';
}
