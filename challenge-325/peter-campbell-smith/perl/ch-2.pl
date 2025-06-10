#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-09
use utf8;     # Week 325 - task 2 - Final price
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

final_price(8, 4, 6, 2, 3);
final_price(1, 2, 3, 4, 5);
final_price(7, 1, 1, 5);
final_price(3);
final_price(7, 7, 7, 7, 7);

sub final_price {
	
	my(@prices, $j, $k);
	
	# initialise
	@prices = @_;
	say qq[\nInput:  (] . join(', ', @prices) . q[)];
	
	# check each price (except the last)
	J: for $j (0 .. $#prices - 1) {
		
		# look over subsequent prices
		for $k ($j + 1 .. $#prices) {
			
			# found a discounting one
			if ($prices[$k] <= $prices[$j]) {
				$prices[$j] -= $prices[$k];
				next J;
			}
		}
	}			
	say qq[Output: (] . join(', ', @prices) . q[)];
}
