#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-19
# PWC 187 task 2

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');
use Algorithm::Combinatorics qw[variations];

# You are given a list of positive numbers, @n, having at least 3 numbers.
# Write a script to find the triplet (a, b, c) from the given list that satisfies the following rules.
# 1. a + b > c
# 2. b + c > a
# 3. a + c > b
# 4. a + b + c is maximum.
# 5. If you end up with more than one triplet having the maximum then pick the triplet where a >= b >= c.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/foo-meets-bar-and-wizardly-trio.html

my (@tests, $test, $iter, $triplet, $sum, $max, @triplet, @results, $r, $j, @rand, @this);

@tests = ([1, 2, 3, 2], [1, 3, 2], [1, 1, 2, 3], [2, 4, 3], [1, 2, 3, 4, 5, 6, 7],
	[1, 7, 13, 34, 51, 78, 0, 4, 56, 43, 199, 20], [1, 0, 0]);
	
for $j (0 .. 19) {
	$rand[$j] = int(rand(1000));
}
push @tests, \@rand;

say qq[\nMETHOD 1];

TEST: for $test (@tests) {
	
	say qq[\nInput:  (] . join(', ', @$test) . ')';

	$max = 0;
	@results = ();
	
	# generate all possible triplets
	$iter = variations($test, 3);
	while ($triplet = $iter->next) {
		
		# apply tests 1 to 3
		next unless $triplet->[0] + $triplet->[1] > $triplet->[2];
		next unless $triplet->[1] + $triplet->[2] > $triplet->[0];
		next unless $triplet->[0] + $triplet->[2] > $triplet->[1];
		
		# calc a + b + c and see if it is >= the max seen so far
		$sum = $triplet->[0] + $triplet->[1] + $triplet->[2];
		next unless $sum >= $max;
		@results = () if $sum > $max;
		push @results, [$triplet->[0], $triplet->[1], $triplet->[2]];
		$max = $sum;
	}

	# no solution
	if (scalar @results == 0) {
		say qq[Output: ()];
		
	# just one solution	
	} elsif (scalar @results == 1) {
		say qq[Output: ($results[0]->[0], $results[0]->[1], $results[0]->[2])];
		
	# several solutions: need to apply test 5 and select the first 
	} else {
		for $r (@results) {
			if ($r->[0] >= $r->[1] and $r->[1] >= $r->[2]) {
				say qq[Output: ($r->[0], $r->[1], $r->[2])];
				next TEST;
			}
		}
		
		# possibly they could all fail test 5
		say qq[Output: ()];  
	}
}

say qq[\nMETHOD 2];

# hypothesis:
# sort the input into decreasing order
# starting from the first element, work along the array until you find
# three successive elements a, b, c where a - b < c, and that's the answer

TEST2: for $test (@tests) {
	
	# sort the input list into decreasing order
	@this = @$test;
	say qq[\nInput:  (] . join(', ', @this) . ')';
	@this = reverse (sort { $a <=> $b } @this);
	
	# work along the list until you find three successive elemenst a, b, c where a - b < c
	for $j (0 .. scalar @this - 3) {
		next if $this[$j] - $this[$j + 1] >= $this[$j + 2];
		say qq[Output: ($this[$j], $this[$j + 1], $this[$j + 2])];
		next TEST2;
	}
	
	# no such triplet meets the criteria
	say qq[Output: ()];
}




