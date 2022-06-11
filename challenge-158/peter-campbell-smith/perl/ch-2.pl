#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-30
# PWC 158 task 2

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util 'is_prime';

my ($y, $test, $result);

# Write a script to compute first series Cuban Primes <= 1000.
# The first Cuban prime series terms are values of 3y^2 + 3y + 1 for y = 1 .. which are prime

# blog: https://pjcs-pwc.blogspot.com/2022/03/all-about-primes.html

$test = 7;   # 3 * $y**2 + 3 * $y + 1 for y == 1
for $y (1 .. 1000) {
	last if $test > 1000;
	$result .= qq[$test, ] if is_prime($test);
	$test += 6 * ($y + 1);
}

say qq[The terms of the first Cuban series <= 1000 are:];
say substr($result, 0, -2) . '.';	
