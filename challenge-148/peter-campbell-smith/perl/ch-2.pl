#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-10
# PWC 148 task 2

use v5.28;
use warnings;
use strict;
use utf8;

# Write a script to generate first 5 Cardano Triplets.  (Let's assume that 'first 5' means
# first 5 ordered by a + b + c.)

# A triplet of positive integers (a,b,c) is called a Cardano Triplet 
# if it satisfies:
# cube_root(a + b * sqrt(c)) + cube_root(a - b * sqrt(c)) = 1

my ($a, $b, $c, $sqrt_c, %results, $cardano, $sum, $answer, $term1, $term2, $j, $b_sqrt_c);

# try 1 million possibilities - probably overkill!
for $c (1 .. 100) {
	$sqrt_c = sqrt($c);
	for $b (1 .. 100) {
		$b_sqrt_c = $b * $sqrt_c;
		for $a (1 .. 100) {
			
			# need to allow for imprecision in floating point operations
			$term1 = cbrt($a + $b_sqrt_c);
			$term2 = cbrt($a - $b_sqrt_c);
			if (abs($term1 + $term2 - 1) < 1e-10) {
				$results{sprintf('%06d¦%s', $a + $b + $c, 
					qq[$a, $b, $c :: $term1 + $term2 = 1])} = 1;
			}	
		}
	}
}
	
# sort and print results in ascending order of a + b + c
$j = 0;
say qq[\nFirst 5 Cardano triplets];
for $cardano (sort keys %results) {
	($sum, $answer) = split('¦', $cardano);
	say $answer;
	say qq[\n... and some more] if ++$j == 5;
}


sub cbrt {
	
	# cube root
	my $arg = $_[0];
	if ($arg >= 0) {
		return $arg ** (1 / 3);
		
	# cube root of -x is minus cube root of x
	} else {
		return -((-$arg) ** (1 / 3));
	}
}