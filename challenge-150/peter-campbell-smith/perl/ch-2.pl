#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-31
# PWC 150 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to generate all square-free integers <= 500.

# In mathematics, a square-free integer (or squarefree integer) is an integer 
# which is divisible by no perfect square other than 1. That is, its prime 
# factorization has exactly one factor for each prime that appears in it. For 
# example, 10 = 2 x 5 is square-free, but 18 = 2 x 3 x 3 is not, because 18 is 
# divisible by 9 = 3**2.

my ($j, $mult, $no_good, $square, $top, @sfi, $results, $count);

$top = 500;

# let's start by guessing that all integers are square-free
for $j (1 .. $top) {
	$sfi[$j] = 1;
}

# now let's knock out anything that is a multiple of a square
for $j (2 .. int(sqrt($top))) {       
	next unless $sfi[$j];   # no need to bother if $j is a known non-square-free
	$square = $j ** 2;
	for ($mult = 1;; $mult ++) {
		$no_good = $mult * $square;
		last if $no_good > $top;
		$sfi[$no_good] = 0;
	}
}

# output what's left neatly
say qq[Square-free integers <= $top: ];
$count = 1;
for $j (1 .. $top) {
	next unless $sfi[$j];
	$results .= $j . ', ';
	$results .= qq[\n] unless ($count++ % 10);
}
$results =~ s|[, \n]+$||;
say $results;
