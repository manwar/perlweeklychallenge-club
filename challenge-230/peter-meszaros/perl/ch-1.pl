#!/usr/bin/env perl

# You are given an array of positive integers.
# 
# Write a script to separate the given array into single digits.
# Example 1
# 
# Input: @ints = (1, 34, 5, 6)
# Output: (1, 3, 4, 5, 6)
# 
# Example 2
# 
# Input: @ints = (1, 24, 51, 60)
# Output: (1, 2, 4, 5, 1, 6, 0)

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[1, 34, 5, 6],
	[1, 24, 51, 60],
];

sub separate_digits
{
	my $arr = shift;

    my @res;
	push @res, split('') for @$arr;

	return \@res;
}

is_deeply(separate_digits($cases->[0]), [1, 3, 4, 5, 6],       '[1, 34, 5, 6]');
is_deeply(separate_digits($cases->[1]), [1, 2, 4, 5, 1, 6, 0], '[1, 24, 51, 60]');
done_testing();

exit 0;
