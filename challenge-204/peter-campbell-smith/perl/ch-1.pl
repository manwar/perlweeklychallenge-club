#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-14

use v5.28;
use utf8;
use warnings;
use Time::HiRes qw(time);

# Task: You are given an array of integers. Write a script to find out if the given array is Monotonic. 
# Print 1 if it is otherwise 0. An array is Monotonic if it is either monotonically increasing or decreasing:
# Monotonically increasing if for i <= j , nums[i] <= nums[j]
# Monotonically decreasing if for i <= j , nums[i] >= nums[j]

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/204/1

my (@tests, $test, @array, $direction, $next, $result, $j);

@tests = ([1, 2, 2, 3], [1, 3, 2], [6, 5, 5, 4], [7, 7, 7, 6, 8], [5, 5, 5, 5, 5]);

for $test (@tests) {
	
	@array = @$test;
	
	$result = 1;
	$direction = 0;
	for $j (0 .. scalar(@array) - 2) {
		$next = $array[$j + 1] <=> $array[$j];
		unless ($direction) {
			$direction = $next;
		} else {
			unless ($next == $direction or $next == 0) {
				$result = 0;
				last;
			}
		}
	}
	say qq[\nInput:  (] . join (', ', @array) . qq[)];
	
	say qq[Output: $result] . ($result == 0 ? '' :
		($direction > 0 ? ' increasing' : ($direction < 0 ? ' decreasing' : ' level')));
}	

