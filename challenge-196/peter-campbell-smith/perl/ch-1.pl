#!/usr/bin/perl

# Peter Campbell Smith - 2022-12-19
# PWC 196 task 1

use v5.28;
use utf8;
use warnings;

# You are given a list of integers, @list. Write a script to find out subsequence that respects Pattern 132. 
# Pattern 132 is a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].
# Return an empty array if no such sequence is found, or the first if several are found.


# Blog: https://pjcs-pwc.blogspot.com/2022/12/pattern-132-and-sequential-runs.html

my (@tests, $test, @list, $j, $last, @hard, $i, $k);

# Mohammad's examples
@tests = ([3, 1, 4, 2], [1, 2, 3, 4], [1, 3, 2, 4, 6, 5], [1, 3, 4, 2]);

# a difficult one
for $j (1 .. 10000) {
	push @hard, $j;
}
push @hard, 9999;
push @tests, \@hard;

# loop over tests
TEST: for $test (@tests) {
	@list = @$test;
	$last = scalar @list - 1;
	
	# loop over j, which is the largest of the three
	J: for $j (1 .. $last - 1) {
		
		# find a smaller $i to the left of $j
		for $i (0 .. $j - 1) {
			if ($list[$i] < $list[$j]) {
				
				# one exists so let's see if there's a smaller $k to the right of $j
				for $k ($j + 1 .. $last) {
					if ($list[$k] < $list[$j]) {
						say qq[\nInput:  \@list = (] . join(', ', @list) . qq[)\nOutput: ($list[$i], $list[$j], $list[$k])];
						next TEST;
					}
				}
				next J;
			}
		}
	}
	say qq[\nInput:  \@list = (] . join(', ', @list) . qq[)\nOutput: none found];
	
}
