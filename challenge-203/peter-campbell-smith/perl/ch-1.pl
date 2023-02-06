#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-06

use v5.28;
use utf8;
use warnings;
use Time::HiRes qw(time);

# Task: You are given an array of integers. Write a script to find out the total special quadruplets for the
# given array. Special Quadruplets are such that satisfies the following 2 rules: 
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d

# Blog: https://pjcs-pwc.blogspot.com/2023/02/quads-and-directory-enquiries.html

my (@tests, $test, @nums, $a, $b, $c, $d, $last, $rubric, $count, @big, $secs, $max);

@tests = ([1, 2, 3, 6], [1, 1, 1, 3, 5], [3, 3, 6, 4, 5], [3, -2, -5, -4]);

# create a longer test
for $a (0 .. 150) {
	$big[$a] = int(rand(50_000));
}
push @tests, \@big;

# loop over tests
say qq[----- simple version -----\n];
for $test (@tests) {
	
	# initialise
	@nums = @$test;
	say qq[Input:  \@nums = (] . join(', ', @nums) . ')';
	
	$last = scalar(@nums) - 1;
	$rubric = '';
	$count = 0;
	$secs = time;
	
	# nested loops over a, b, c and d
	for $a (0 .. $last - 3) {
		for $b ($a + 1 .. $last - 2) {
			for $c ($b + 1 .. $last - 1) {
				for $d ($c + 1 .. $last) {
					if ($nums[$a] + $nums[$b] + $nums[$c] == $nums[$d]) {
						$count ++;
						$rubric .= qq[\$nums[$a] + \$nums[$b] + \$nums[$c] == \$nums[$d] | $nums[$a] + $nums[$b] + $nums[$c] == $nums[$d]\n];
					}
				}
			}
		}
	}
	say qq[Output: $count (] . sprintf('time: %0.2f', time - $secs) . qq[ secs)\n\n$rubric];
}

# faster version - abandon each loop if the partial sum exceeds the maximum number in @nums
say qq[----- improved version -----/n];
for $test (@tests) {
	
	# initialise
	@nums = @$test;
	say qq[Input:  \@nums = (] . join(', ', @nums) . ')';
	
	$last = scalar(@nums) - 1;
	$rubric = '';
	$count = 0;
	$secs = time;
	
	# find the largest number
	$max = -1e10;
	for $a (@nums) {
		$max = $a if $a > $max;
	}
	
	# nested loops over a, b, c and d, but abandon the b and c loops if the partial sum exceeds $max
	for $a (0 .. $last - 3) {
		for $b ($a + 1 .. $last - 2) {
			next if $nums[$a] + $nums[$b] > $max;
			for $c ($b + 1 .. $last - 1) {
				next if $nums[$a] + $nums[$b] + $nums[$c] > $max;
				for $d ($c + 1 .. $last) {
					if ($nums[$a] + $nums[$b] + $nums[$c] == $nums[$d]) {
						$count ++;
						$rubric .= qq[\$nums[$a] + \$nums[$b] + \$nums[$c] == \$nums[$d] | $nums[$a] + $nums[$b] + $nums[$c] == $nums[$d]\n];
					}
				}
			}
		}
	}
	say qq[Output: $count (] . sprintf('time: %0.2f', time - $secs) . qq[ secs)\n\n$rubric];
}	
