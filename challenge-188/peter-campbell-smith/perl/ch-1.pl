#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-26
# PWC 188 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given list of integers @list of size $n and divisor $k.
# Write a script to find out count of pairs in the given list that satisfies the following rules.
# The pair (i, j) is eligible if and only if
# a) 0 <= i < j < len(list)
# b) list[i] + list[j] is divisible by k

# Blog: 

my (@tests, @list, $k, $n, $i, $j, $count, $reason);

# test input (\@list, $k ...)
@tests = ([4, 5, 1, 6], 2, [1, 2, 3, 4], 2, [1, 3, 4, 5], 3, [5, 1, 2, 3], 4, [7, 2, 4, 5], 4,
	[3, 6, 9, 12, 15], 11, [7, 9, 8, 3, 4, 0, 1, 11, 6, 12, 10, 6, 2], 3);

# loop over tests
while ($tests[0]) {
	
	# initialise
	@list = @{shift @tests};
	$k = shift @tests;
	$n = scalar @list;
	$count = 0;
	$reason = '';
	
	#loop over i and j such as to apply test a
	for $i (0 .. $n - 2) {
		for $j ($i + 1 .. $n - 1) {
			
			# apply test b
			next unless (($list[$i] + $list[$j]) % $k) == 0;
			
			# found an answer
			$count ++;
			$reason .= qq[($list[$i] + $list[$j]), ];
		}
	}
	# output
	say qq[\nInput: \@list = ] . join(', ', @list) . qq[, \$k = $k\nOutput: $count\nReason: ] . substr($reason, 0, -2);	
}




