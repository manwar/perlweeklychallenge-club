#!/usr/bin/env perl
#
# You are given an array of unique numbers.
# Write a script to find out all missing numbers in the range 0..$n where $n is the array size.
#

use strict;
use warnings;

#~ my @num_array = (2, 1, 4, 3);
my @num_array = (0, 1, 2, 3, 4);
my $array_len = scalar(@num_array);
my %array_hash = map { $_ => 1 } @num_array;

print("Array length is: $array_len \n");

foreach ( 0..$array_len ){
	if (! exists($array_hash{$_})){
		print("Array is missing $_!\n");
		last;
	}
}
