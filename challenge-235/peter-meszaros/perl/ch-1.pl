#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to find out if removing ONLY one integer makes it strictly
# increasing order.
# Example 1
# 
# Input: @ints = (0, 2, 9, 4, 6)
# Output: true
# 
# Removing ONLY 9 in the given array makes it strictly increasing order.
# 
# Example 2
# 
# Input: @ints = (5, 1, 3, 2)
# Output: false
# 
# Example 3
# 
# Input: @ints = (2, 2, 3)
# Output: true
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [0, 2, 9, 4, 6],
    [5, 1, 3, 2],
    [2, 2, 3],
];

sub remove_one
{
    my $l = shift;

    my $e = shift @$l;
	my $r;
    while (my $n = shift @$l) {
		if ($e >= $n) {
			++$r;
			return 0 if $r > 1;
		}
		$e = $n;
    }
	return 1;
}

is(remove_one($cases->[0]), 1, '[0, 2, 9, 4, 6]');
is(remove_one($cases->[1]), 0, '[5, 1, 3, 2]');
is(remove_one($cases->[2]), 1, '[2, 2, 3]');
done_testing();

exit 0;
