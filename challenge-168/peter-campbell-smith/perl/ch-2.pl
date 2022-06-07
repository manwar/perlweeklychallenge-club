#!/usr/bin/perl

# Peter Campbell Smith - 2022-06-06
# PWC 168 task 2

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util qw[factor is_prime];

# You are given an integer greater than 1.
# Write a script to find the home prime of the given number.

# In number theory, the home prime HP(n) of an integer n greater than 1 is the prime 
# number obtained by repeatedly factoring the increasing concatenation of prime factors 
# including repetitions.

# Blog at https://pjcs-pwc.blogspot.com/2022/06/more-funny-numbers-and-very-big-one.html

my ($test, $hp);

# loop over 2 to 48 (49 is known to be difficult!)
for $test (2 .. 48) {
	$hp = home($test);
	say qq[hp($test) = $hp];
}

sub home {
	
	my (@prime_factors, $concat);
	
	# get prime factors
	@prime_factors = factor(shift);
	
	# concatenate them
	$concat .= $_ for @prime_factors;
	
	# either we have an answer or need to go round again
	return $concat if is_prime($concat);
	home($concat);
}
