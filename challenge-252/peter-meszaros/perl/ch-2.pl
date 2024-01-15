#!/usr/bin/env perl
#
# You are given an integer, $n.
# 
# Write a script to find an array containing $n unique integers such that they add up to zero.
# Example 1
# 
# Input: $n = 5
# Output: (-7, -1, 1, 3, 4)
# 
# Two other possible solutions could be as below:
# (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
# 
# Example 2
# 
# Input: $n = 3
# Output: (-1, 0, 1)
# 
# Example 3
# 
# Input: $n = 1
# Output: (0)
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    5,
    3,
    1,
    6,
];

sub unique_sum_zero
{
    my $n = shift;

    my $arr = [];
    for my $i (1..($n/2)) {
        push @$arr, $i, -$i;
    }
    push @$arr, 0 if $n % 2;

    return $arr;
}

is(unique_sum_zero($cases->[0]), [1, -1, 2, -2, 0],     'Example 1');
is(unique_sum_zero($cases->[1]), [1, -1, 0],            'Example 2');
is(unique_sum_zero($cases->[2]), [0],                   'Example 3');
is(unique_sum_zero($cases->[3]), [1, -1, 2, -2, 3, -3], 'Example 4');
done_testing();

exit 0;

         
