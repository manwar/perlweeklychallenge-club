#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-19
# PWC 174 task 1

use v5.28;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':utf8');

# Write a script to generate first 19 Disarium Numbers. A disarium number is an integer where the 
# sum of each digit raised to the power of its position in the number, is equal to the number.

# Blog: https://pjcs-pwc.blogspot.com/2022/07/disarium-disaster-and-rank-permutations.html

my ($j, $k, $sum, $count, $digit, $s1, $s2);

# loop over everything
NUMBER: for $j (0 .. 0xffffffff) {   # 2**64
	
	# calculate the Disarian sum
	$sum = 0;
	for ($k = length($j); $k >= 1; $k --) {
		$sum += substr($j, $k - 1, 1) ** $k;
		next NUMBER if $sum > $j;   # too big already - give up
	}
	next unless $sum == $j;
	
	# produce Mohammad's output
	$s1 = $s2 = '';
	for $k (1 .. length($j)) {
		$digit = substr($j, $k - 1, 1);
		$s1 .= qq[($digit ** $k) + ];
		$s2 .= ($digit ** $k) . ' + ';
	}
	say substr($s1, 0, -3) . ' => ' . substr($s2, 0, -3) . ' => ' . $j;
	last if ++$count == 19;
}

