#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-07
# PWC 155 task 1

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util 'is_prime';
use Math::BigInt lib => 'GMP';

# A Fortunate number, named after Reo Fortune, is the smallest integer m > 1 such that, 
# for a given positive integer n, pn# + m is a prime number, where the primorial pn# is 
# the product of the first n prime numbers.
# Write a script to produce first 8 Fortunate Numbers (unique and sorted).

# Blog at https://pjcs-pwc.blogspot.com/2022/03/bigint-week.html

my ($limit, $lines, @pn, $try, %results, $r);

# populate $pn[$n] up to $pn[$limit]
$limit = 100;
make_pn($limit);

# loop over n and m as defined above
N: for my $n (2 .. $limit) {
	for my $m (2 .. 150) {
		
		# calculate pn# + m
		$try = Math::BigInt->new($pn[$n]); 
		$try = $try->badd($m);
		
		# if that's prime we have a result
		if (is_prime($try)) {
			$results{sprintf('%08d', $m)} = 1;
			next N;
		}
	}
}

# format results as requested
for $r (sort keys %results) {
	print qq[First 8 Fortunate numbers: ] unless $lines ++;
	print qq[\nand then: ] if $lines == 9;
	print '' . ($r + 0) . ' ';
}
print qq[\n];

#---

sub make_pn {
	
	my ($arg, $prev, $n, $j);
	
	# populate $pn[$n] up to $pn[$limit]
	$arg = shift;
	$n = 1;
	$pn[1] = Math::BigInt->new(1);
	for ($j = 2; $n < $arg; $j ++) {
		next unless is_prime($j);
		$n ++;
		$pn[$n] = Math::BigInt->new($pn[$n - 1]);
		$pn[$n] = $pn[$n]->bmul($j);
	}
}
		