#!/usr/bin/perl

=com
You are given an array of integers.

Write a script to return the maximum between the number of positive and negative integers. Zero is neither positive nor negative.


Example 1
Input: @ints = (-3, -2, -1, 1, 2, 3)
Output: 3

There are 3 positive integers.
There are 3 negative integers.
The maximum between 3 and 3 is 3.

Example 2
Input: @ints = (-2, -1, 0, 0, 1)
Output: 2

There are 1 positive integers.
There are 2 negative integers.
The maximum between 2 and 1 is 2.

Example 3
Input: @ints = (1, 2, 3, 4)
Output: 4

There are 4 positive integers.
There are 0 negative integers.
The maximum between 4 and 0 is 4.
=cut

use strict;
use warnings;
use Data::Dumper;
use List::Util qw/max/;

my @array = qw/-2 -1 0 0 1/;

my (@negative_nums, @positive_nums);

foreach (@array){
	if ($_ > 0){
		push (@positive_nums, $_);
	} elsif ($_ < 0) {
		push (@negative_nums, $_);
	}
}

print "There are ".scalar(@positive_nums)." positive integers.";
print "\nThere are ".scalar(@negative_nums)." negative integers.";

my $max = (scalar(@positive_nums), scalar(@negative_nums));
print "\nThe maximum between ".scalar(@positive_nums)." and ".scalar(@negative_nums)." is ".$max."\n";