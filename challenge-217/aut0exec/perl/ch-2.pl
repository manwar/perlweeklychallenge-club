#!/usr/bin/env perl
#
# Author:   Aut0exec
#
# You are given a list of positive integers.
# Write a script to concatenate the integers to form the highest possible value.
# Example 1:
#	Input: @list = (1, 23)
#	Output: 231
#
########################################################################

use strict;
use warnings;

my @list = (11, 2, 34, 65, 15, 3, 0);
my @sorted = sort {$a <= $b} (sort { $a <=> $b} @list);
my $list_len = @sorted;

print("Output: ");
for(my $i = 0; $i < $list_len; $i++) {
	print("$sorted[$i]");
}
print("\n");
