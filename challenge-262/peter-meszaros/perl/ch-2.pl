#!/usr/bin/env perl
#
# You are given an array of integers, @ints and an integer $k.
# 
# Write a script to return the number of pairs (i, j) where
# 
# a) 0 <= i < j < size of @ints
# b) ints[i] == ints[j]
# c) i x j is divisible by k
# 
# Example 1
# 
# Input: @ints = (3,1,2,2,2,1,3) and $k = 2
# Output: 4
# 
# (0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
# (2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
# (2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
# (3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2
# 
# Example 2
# 
# Input: @ints = (1,2,3) and $k = 1
# Output: 0
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[3, 1, 2, 2, 2, 1, 3], 2], 4, 'Example 1'],
    [[[1, 2, 3], 1],             0, 'Example 2'],
];

sub count_equal_divisable
{
    my $l = $_[0]->[0];
    my $k = $_[0]->[1];

    my $r = 0;
    my $c = 0;
    while (my $i = shift @$l) {
        for my $n (0..$#$l) {
            if ($i == $l->[$n]) {
                my $v = $c * $n / $k;
                ++$r if $v == int($v);
            }
        }
        ++$c;
    }

    return $r;
}

for (@$cases) {
    is(count_equal_divisable($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

