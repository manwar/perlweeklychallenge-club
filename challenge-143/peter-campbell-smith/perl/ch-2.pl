#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-13
# PWC 143 task 2

use v5.20;
use warnings;
use strict;

use Math::Prime::Util qw(divisors);
use Algorithm::Combinatorics qw(variations);

# You are given a positive number, $n.
# Write a script to find out if the given number is Stealthy Number.
# A positive integer N is stealthy, if there exist positive integers a, b, c, d 
# such that a * b = c * d = N and a + b = c + d + 1.

my ($test, @tests, @divisors, $variations, $v, $good, $half);

# inputs
@tests = (36, 12, 6, 22, 23, 24, 8424, 7200, 4);

# eval will do it
for $test (@tests) {
	$good = 0;
	@divisors = divisors($test);
	$variations = variations(\@divisors, 2);
	$half = sqrt($test);
	while ($v = $variations->next) {
		next unless ($v->[0] <= $half and $v->[1] <= $half);
		if ($v->[0] + $test / $v->[0] == $v->[1] + $test / $v->[1] + 1) {
			say qq[\nInput:  $test\nOutput: 1] if $good == 0;
			say qq[$v->[0] + ] . ($test / $v->[0]) . qq[ == $v->[1] + ] . ($test / $v->[1]) . qq[ + 1];
			$good ++;
		}
	}
	say qq[\nInput:  $test\nOutput: 0] unless $good;
}
