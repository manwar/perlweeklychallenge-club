#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-09
# PWC 199 task 2

use v5.28;
use utf8;
use warnings;

# You are given an array of integers, @array and three integers $x, $y, $z.
# Write a script to find out total Good Triplets in the given array.
# A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:

# 0 <= i < j < k <= n (size of given array)
# abs(array[i] - array[j]) <= x
# abs(array[j] - array[k]) <= y
# abs(array[i] - array[k]) <= z

# Blog: https://pjcs-pwc.blogspot.com/2023/01/all-good-things.html

# loop over tests
good_triplets(7, 2, 3, [3, 0, 1, 1, 9, 7]);
good_triplets(0, 0, 1, [1, 1, 2, 2, 3]);
good_triplets(1, 2, 1, [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]);

sub good_triplets {

	# initialise
	my ($i, $j, $k, @array, $rubric, $count, $max_i, $max_j, $max_k);
	my ($x, $y, $z, $a) = @_;
	@array = @$a;
	$max_k = scalar(@array) - 1;
	$max_j = $max_k - 1;
	$max_i = $max_j - 1;
	
	# loop over i, j, k such that i < j < k
	for $i (0 .. $max_i) {
		for $j ($i + 1 .. $max_j) {
			
			# if this test fails then no need to check $k
			next unless abs($array[$i] - $array[$j]) <= $x;
			
			# apply tests on $k
			for $k ($j + 1 .. $max_k) {
				if (abs($array[$j] - $array[$k]) <= $y and
					abs($array[$i] - $array[$k]) <= $z)	{
					$rubric .= qq[($array[$i], $array[$j], $array[$k]) where (i = $i, j = $j, k = $k)\n];
					$count ++;
				}
			}
		}
	}
	
	# output result
	say qq[Input: \@array = (] . join(', ', @array) . qq[), x = $x, y = $y, z = $z];
	say $count ? qq[Output: $count\nGood triplets are:\n$rubric] : qq[Output: 0\n];
}
