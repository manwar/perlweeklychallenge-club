#!/usr/bin/perl

# Peter Campbell Smith - 2022-06-13
# PWC 169 task 2

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util qw[factor];

# Write a script to generate first 20 Achilles Numbers: numbers that are powerful but imperfect. A positive integer
# n is a powerful number if, for every prime factor p of n, p^2 is also a divisor. A number is imperfect if it has 
# at least two distinct prime factors.

# Blog at https://pjcs-pwc.blogspot.com/2022/06/brilliant-and-achilles.html

my ($test, @pf, $f, $result, $count, $dpf, %seen, $p, $rarest_factor, $good);

# loop from 1 up until done
TEST: for ($test = 1, $count = 0; $count < 20; $test ++) {
	
	# get prime factors
	@pf = factor($test);
	
	# test for powerfulness
	$dpf = 0;
	%seen = ();
	for $f (@pf) {
		
		# discard unless $test is a multiple of prime factor $f squared
		next TEST unless $test % ($f ** 2) == 0;
		
		# count distinct prime factors and their frequency
		$dpf ++ unless $seen{$f};
		$seen{$f} ++;
	}
	
	# test for imperfection
	next unless $dpf >= 2;
	
	# test for not a perfect power: first find the least frequently repeating prime factor
	$rarest_factor = ~0;
	for $f (keys %seen) {
		last if $seen{$f} == 1;
		$rarest_factor = $seen{$f} if $seen{$f} < $rarest_factor;
	}
	
	# then check that at least one other pf repeats a non-multiple of time the least frequent
	$good = 0;
	for $f (keys %seen) {
		$good = 1 if $seen{$f} % $rarest_factor != 0;
	}
	next TEST unless $good;
	
	# accumulate answers
	$result .= qq[$test, ];
	$count ++;
}

# tell the world
say substr($result, 0, -2);
