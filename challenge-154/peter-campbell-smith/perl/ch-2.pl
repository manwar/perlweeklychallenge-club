#!/usr/bin/perl

# Peter Campbell Smith - 2022-02-28
# PWC 154 task 2

use v5.28;
use strict;
use utf8;
use Math::Prime::Util 'is_prime';
use Math::BigInt lib => 'GMP';

# In number theory, the Padovan sequence is the sequence of integers P(n) defined by the initial values
# P(0) = P(1) = P(2) = 1 and then followed by P(n) = P(n-2) + P(n-3).
# Write a script to compute first 10 distinct Padovan Primes.

# Blog: https://pjcs-pwc.blogspot.com/2022/02/perming-perl-plus-padovan-primes.html

my (@p, $n, $string, $count);

# as in challenge text
$p[0] = $p[1] = $p[2] = '1';

# make successive Padovan numbers
for ($n = 3; $count <= 10; $n ++) {
	$p[$n] = Math::BigInt->new($p[$n - 2]);
	$p[$n]->badd($p[$n - 3]);
	
	# but is it prime?
	if (is_prime($p[$n])) {
		$string .= qq[$p[$n], ];
		$count ++;
	}
}

# eliminate the repeated '2' and the final ', '
say substr($string, 3, -2);	
