#!/usr/bin/env perl
#
# You are given an array of integers, @ints.
# 
# Write a script to return 1 if the number of occurrences of each value in the
# given array is unique or 0 otherwise.
# Example 1
# 
# Input: @ints = (1,2,2,1,1,3)
# Output: 1
# 
# The number 1 occurred 3 times.
# The number 2 occurred 2 times.
# The number 3 occurred 1 time.
# 
# All occurrences are unique, therefore the output is 1.
# 
# Example 2
# 
# Input: @ints = (1,2,3)
# Output: 0
# 
# Example 3
# 
# Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
# Output: 1
# 
#
use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/uniqint/;

my $cases = [
    [1, 2, 2, 1, 1, 3],
    [1, 2, 3],
    [-2, 0, 1, -2, 1, 1, 0, 1, -2, 9],
];

sub unique_occurences
{
    my $l = shift;

    my %h;
    ++$h{$_} for @$l;

    return (uniqint values %h) == (keys %h) ? 1 : 0;
}

is(unique_occurences($cases->[0]), 1, 'Example 1');
is(unique_occurences($cases->[1]), 0, 'Example 2');
is(unique_occurences($cases->[2]), 1, 'Example 3');
done_testing();

exit 0;
