#!/usr/bin/env perl
#
# You are given an array of integers, @ints.
#
# Write a script to find the concatenation value of the given array.
# 
# The concatenation of two numbers is the number formed by concatenating their
# numerals.
# 
# For example, the concatenation of 10, 21 is 1021.
# The concatenation value of @ints is initially equal to 0.
# Perform this operation until @ints becomes empty:
# 
# If there exists more than one number in @ints, pick the first element
# and last element in @ints respectively and add the value of their
# concatenation to the concatenation value of @ints, then delete the
# first and last element from @ints.
# 
# If one element exists, add its value to the concatenation value of
# @ints, then delete it.
# 
# Example 1
# 
# Input: @ints = (6, 12, 25, 1)
# Output: 1286
# 
# 1st operation: concatenation of 6 and 1 is 61
# 2nd operation: concaternation of 12 and 25 is 1225
# 
# Concatenation Value => 61 + 1225 => 1286
# 
# Example 2
# 
# Input: @ints = (10, 7, 31, 5, 2, 2)
# Output: 489
# 
# 1st operation: concatenation of 10 and 2 is 102
# 2nd operation: concatenation of 7 and 2 is 72
# 3rd operation: concatenation of 31 and 5 is 315
# 
# Concatenation Value => 102 + 72 + 315 => 489
# 
# Example 3
# 
# Input: @ints = (1, 2, 10)
# Output: 112
# 
# 1st operation: concatenation of 1 and 10 is 110
# 2nd operation: only element left is 2
# 
# Concatenation Value => 110 + 2 => 112
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [6, 12, 25, 1],
    [10, 7, 31, 5, 2, 2],
    [1, 2, 10],
];

sub concatenation_value
{
    my $l = shift;

    my $v = 0;
    for my $i (0..($#$l/2)) {
        my $j = $#$l - $i;
        $v += ($i == $j) ? $l->[$i] : ($l->[$i] . $l->[$j]);
    }

    return $v;
}

is(concatenation_value($cases->[0]), 1286, 'Example 1');
is(concatenation_value($cases->[1]),  489, 'Example 2');
is(concatenation_value($cases->[2]),  112, 'Example 3');
done_testing();

exit 0;
