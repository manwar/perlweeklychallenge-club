#!/usr/bin/env perl

# You are given an array of distinct integers.
# 
# Write a script to find all elements that is neither minimum nor maximum. Return
# -1 if you can’t.
#
# Example 1
# 
# Input: @ints = (3, 2, 1, 4) Output: (3, 2)
# 
# The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min
# nor max.
# 
# Example 2
# 
# Input: @ints = (3, 1) Output: -1
# 
# Example 3
# 
# Input: @ints = (2, 1, 3) Output: (2)
# 
# The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use List::MoreUtils qw/minmax/;

my $cases = [
	[3, 2, 1, 4],
	[3, 1],
	[2, 1, 3],
];

sub min_max
{
	my $l = shift;
    my ($max, $min) = minmax @$l;

    my @r = grep { $_ != $max && $_ != $min } @$l;

	return @r ? \@r : [-1];
}

is_deeply(min_max($cases->[0]), [3, 2], '[3, 2, 1, 4]');
is_deeply(min_max($cases->[1]), [-1],   '[3, 1]');
is_deeply(min_max($cases->[2]), [2],    '[2, 1, 3]');
done_testing();

exit 0;
