#!/usr/bin/env perl
#
# You are given a array of positive integers, @ints.
# 
# Write a script to find out how many integers have even number of digits.
# Example 1
# 
# Input: @ints = (10, 1, 111, 24, 1000)
# Output: 3
# 
# There are 3 integers having even digits i.e. 10, 24 and 1000.
# 
# Example 2
# 
# Input: @ints = (111, 1, 11111)
# Output: 0
# 
# Example 3
# 
# Input: @ints = (2, 8, 1024, 256)
# Output: 1
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[10, 1, 111, 24, 1000],
	[111, 1, 11111],
	[2, 8, 1024, 256],
];

sub count_even_digits_number
{
	my $ints = shift;

	return scalar grep { not split('') % 2 } @$ints;
}

is(count_even_digits_number($cases->[0]), 3, 'Example 1');
is(count_even_digits_number($cases->[1]), 0, 'Example 2');
is(count_even_digits_number($cases->[2]), 1, 'Example 3');
done_testing();

exit 0;
