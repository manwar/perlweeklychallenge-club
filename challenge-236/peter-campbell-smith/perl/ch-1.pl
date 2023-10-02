#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-25
use utf8;     # Week 236 task 1 - Exact change
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

exact_change(5, 5, 5, 10, 20);
exact_change(5, 5, 10, 10, 20);
exact_change(5, 5, 5, 20);
exact_change(5, 5, 10, 20);

sub exact_change {
	
	my (@bills, $bill, $change, @till, $ok, $explain, $j);
	
	# initialise
	@bills = @_;
	$ok = 'true';
	
	# till starts empty
	$till[5] = $till[10] = $till[20] = 0;
	
	# loop over customers
	for $bill (@bills) {
		$explain .= qq[\n   \$$bill paid];
		$change = $bill - 5;
		
		# customer presents $5 - no change needed
		if ($change == 0) {
			$explain .= q[, no change due];
		
		# customer presents $10 so give him $5 change if we have a $5
		} elsif ($change == 5) {
			if ($till[5] > 0) {
				$till[5] --;
				$explain .= q[, $5 change];
			} else {
				$ok = 'false'; # we don't
			}
		
		# customer presents $20 so give her a $10 and a $5, or 3 x $5
		} elsif ($change == 15) {
			if ($till[10] > 0 and $till[5] > 0) {
				$till[10] --;
				$till[5] --;
				$explain .= q[, $10 + $5 change];
			} elsif ($till[5] >= 3) {
				$till[5] -= 3;
				$explain .= q[, 3 x $5 change];
			} else {
				$ok = 'false'; # we have neither
			}
		}
		
		# oh dear!
		unless ($ok eq 'true') {
			$explain .= q[, sorry, I don't have change];
			last;
		}
			
		# add customer's payment to till
		$till[$bill] ++;
		$explain .= qq[, till now $till[5] x \$5, $till[10] x \$10 $till[20] x \$20 = \$] .
			($till[5] * 5 + $till[10] * 10 + $till[20] * 20);
	}		
	
	say qq[\nInput: \@bills = (] . join(', ', @bills) . ')';
	say qq[Output: $ok$explain];
}
