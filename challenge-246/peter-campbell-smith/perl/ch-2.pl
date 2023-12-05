#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-12-04
use utf8;     # Week 246 task 2 - Linear recurrence of second order
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

linear_recurrence(1, 1, 2, 3, 5);
linear_recurrence(4, 2, 4, 5, 7);
linear_recurrence(4, 1, 2, -3, 8);
linear_recurrence(4, 1, 2, -3, 9);
linear_recurrence(2, 0, 2, 4, 10);
linear_recurrence(5, 5, 5, 5, 5);
linear_recurrence(7, 8, 0, 0, 0);
linear_recurrence(5, 5, -10, 5, 5);
linear_recurrence(5, 5, -10, 5, 6);
linear_recurrence(-1000, 999, 36977, 836485, 18721477);

sub linear_recurrence {
	
	my (@s, $p, $q, $good, $j, $z);
	
	# initialise
	@s = @_;
	say qq[\nInput:  ] . join(', ', @s);
	if ($#s != 4) {
		say qq[   bad input - must have 5 integers];
		return;
	}
	$good = '';
	
	# check for well-behaved-ness
	if ($s[0] * $s[2] - $s[1] ** 2 != 0 and $s[1] != 0) {
		$p = ($s[2] ** 2 - $s[3] * $s[1]) / ($s[0] * $s[2] - $s[1] ** 2);
		$q = ($s[2] - $s[0] * $p) / $s[1];
	} elsif ($s[1] ** 2 - $s[2] * $s[0] != 0 and $s[0] != 0) {
		$q = ($s[2] * $s[1] - $s[3] * $s[0]) / ($s[1] ** 2 - $s[2] * $s[0]);
		$p = ($s[2] - $s[1] * $q) / $s[0];
	} else {

		# loop over possible p and q values
		$good = 'false';
		P: for ($p = 0; $p <= abs($s[2]); $p ++) {
			for ($q = 0; $q <= abs($s[2]); $q ++) {
				
				# check +ve and -ve p and q
				for $z (0 .. 3) {
					if ($p * $s[0] + $q * $s[1] == $s[2]
						and $p * $s[1] + $q * $s[2] == $s[3]
						and $p * $s[2] + $q * $s[3] == $s[4]) {
						$good = 'true';
						last P;
					}
					
					$q = -$q;
					$p = -$p if $z == 1;
				}
			}
		}
	}	
			
	$good = ($p == int($p) and $q == int($q) and $s[4] == $p * $s[2] + $q * $s[3]) ? 'true' : 'false';
	$good .= qq[ (p = $p, q = $q)] if $good eq 'true';
	
	say qq[Output: $good];
	
	# show the first 12 members
	if ($good =~ m|^true|) {
		for $j (5 .. 11) {
			$s[$j] = $s[$j - 2] * $p + $s[$j - 1] * $q;
		}
		say '   ' . join(', ', @s) . ' ...';
	}
}
	