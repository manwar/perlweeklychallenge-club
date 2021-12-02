#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-01
# PWC 141 task 2

use v5.20;
use warnings;
use strict;

# You are given positive integers, $m and $n.
# Write a script to find total count of integers created using the digits
# of $m which is also divisible by $n.

my (@tests, $test, $m, $n, $num_digits, @digits, $i, $iter, $c,
	$extract, $all, $good, $num_good);

use Algorithm::Combinatorics qw(combinations);

# pairs of $m and $n
@tests = ([1234, 2], [768, 4], [1234567, 31]);

# loop over pairs
for $test (@tests) {
	$all = $good = '';
	$num_good = 0;
	($m, $n) = @$test;

	# split $m into an array of digits
	$num_digits = length($m);
	@digits = split(//, $m);

	# need all the combinations of 1, 2 ... (length - 1) digits
	for $i (1..$num_digits - 1) {
        $iter = combinations(\@digits, $i);

		# loop over combinations
		while ($c = $iter->next) {

			# join digits of combination together
			$extract = join('', @$c);

			# create string of $all combs and $good combs divisible by $n
			$all .= qq[$extract, ];
            if ($extract % $n == 0) {
				$good .= qq[$extract, ];
				$num_good ++;
			}
		}
	}

	# trim trailing commas and show answer
	$all =~ s|..$||;
	$good =~ s|..$||;
	say qq[Possible integers created using the digits of $m are:\n$all];
	say qq[There are $num_good integers divisible by $n which are:\n$good\n];
}
