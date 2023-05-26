#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-22
use utf8;     # Week 218 task 1 - Maximum product
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

max_product(1, 2, 3, 4, 5);
max_product(-8, 2, -9, 0, -4, 3);
max_product(-9, -8, -7, -6, -5);
max_product(5, 6, 0);

sub max_product {
	
	my (@list, $product, $count, $j, $last_negative, $explain, $k, $last, $negatives);
	
	@list = @_;
	say qq[\nInput:  (] . join(', ', @list) . ')';
	@list = sort { abs($b) <=> abs($a) } @list;
	
	$product = 1;
	$count = 3;
	$last = scalar @list - 1;
	die 'Not enough data' if $last < 2;
	
	# check for special case where list is all negatives
	$negatives = 0;
	$negatives += $_ < 0 ? 1 : 0 for @list;
	
	# not the special case
	if ($negatives != $last + 1) {
		for $k (0 .. $last) {

			# multiply next number into product
			$j = $list[$k];
			$product *= $j;
			$explain .= qq[$j x ];
			
			# note last negative one in case we need to back it out
			$last_negative = $j if $j < 0;
			$count --;
			
			# if we've multiplied 3 and the result is +ve then we're done
			if ($count == 0) {
				last if $product >= 0;
				
				# and we're done if there are no more entries
				last if $k == $last;
				
				# else we need to back out the last negative one and try again
				$product /= $last_negative;
				$explain =~ s|$last_negative x ||;
				$count = 1;
			}		
		}
		
	# special case
	} else {
		$product = $list[$last - 2] * $list[$last - 1] * $list[$last];
		$explain =  qq[$list[$last - 2] x $list[$last - 1] x $list[$last] x ];
		
	}
	say qq[Output: $product = ] . substr($explain, 0, -3);
}
