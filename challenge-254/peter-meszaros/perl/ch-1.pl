#!/usr/bin/env perl
#
# You are given a positive integer, $n.
# 
# Write a script to return true if the given integer is a power of three
# otherwise return false.
# Example 1
# 
# Input: $n = 27
# Output: true
# 
# 27 = 3 ^ 3
# 
# Example 2
# 
# Input: $n = 0
# Output: true
# 
# 0 = 0 ^ 3
# 
# Example 3
# 
# Input: $n = 6
# Output: false
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [27],
    [0],
    [6],
    [1],
    [3],
    [4]
];

sub three_power
{
    my $n = shift;

    while ($n) {
        last if $n % 3;
        $n /= 3;
    }
    return $n == 1 ? 1 : 0;
}

is(three_power($cases->[0]->@*), 1, 'Example 1 ' . $cases->[0]->[0]);
is(three_power($cases->[1]->@*), 0, 'Example 2 ' . $cases->[1]->[0]);
is(three_power($cases->[2]->@*), 0, 'Example 3 ' . $cases->[2]->[0]);
is(three_power($cases->[3]->@*), 1, 'Example 4 ' . $cases->[3]->[0]);
is(three_power($cases->[4]->@*), 1, 'Example 5 ' . $cases->[4]->[0]);
is(three_power($cases->[5]->@*), 0, 'Example 6 ' . $cases->[5]->[0]);
done_testing();

exit 0;
