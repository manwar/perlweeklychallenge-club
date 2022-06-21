#!/usr/bin/perl

# Peter Campbell Smith - 2022-06-20
# PWC 170 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to generate first 10 Primorial Numbers.
# Primorial numbers are those formed by multiplying successive prime numbers.

# Blog: https://pjcs-pwc.blogspot.com/2022/06/primorials-and-kronecker-products.html

my (@primes, $j, $p, @pm, $k);

@primes = ();
$p = 1;
$pm[0] = 1;
say qq[P(0) = 1];

OUTER: for $j (2 .. 99999) {
	for $k (@primes) {
		next OUTER if $j % $k == 0;   # $j is not prime if divisible by a smaller prime
	}
	
	# found a prime, create next primorial
	push @primes, $j;
	$pm[$p] = $pm[$p - 1] * $j;
	say qq[P($p) = $pm[$p]];
	$p ++;
	exit if $p == 10;
}
