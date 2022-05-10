#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-09
# PWC 164 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to find all prime numbers less than 1000, which are also palindromes in base 10.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/palindromic-primes-and-moody-numbers.html

my (%primes, $j, $p, $results, $reverse);

# discover primes
%primes = ();
OUTER: for $j (2 ... 1000) {
	
	# not prime if $j divisible by a lesser prime
	for $p (keys %primes) {
		next OUTER if $j % $p == 0;
	}
	
	# found a prime, check for palindromicity
	$primes{$j} = 1;
	$reverse = '';
	$reverse = $reverse . $1 while $j =~ m|(.)|g;
	$results .= qq[$j, ] if $j == reverse($j);
}
say qq[\nThe following are palindromic primes:\n] . substr($results, 0, -2);
