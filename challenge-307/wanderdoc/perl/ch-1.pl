#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to re-arrange the given array in an increasing order and return the indices where it differs from the original array.
Example 1

Input: @ints = (5, 2, 4, 3, 1)
Output: (0, 2, 3, 4)

Before: (5, 2, 4, 3, 1)
After : (1, 2, 3, 4, 5)

Difference at indices: (0, 2, 3, 4)

Example 2

Input: @ints = (1, 2, 1, 1, 3)
Output: (1, 3)

Before: (1, 2, 1, 1, 3)
After : (1, 1, 1, 2, 3)

Difference at indices: (1, 3)

Example 3

Input: @ints = (3, 1, 3, 2, 3)
Output: (0, 1, 3)

Before: (3, 1, 3, 2, 3)
After : (1, 2, 3, 3, 3)

Difference at indices: (0, 1, 3)

=cut

use Test2::V0 -no_srand => 1;

is(check_order(5, 2, 4, 3, 1), [0, 2, 3, 4], 'Example 1');
is(check_order(1, 2, 1, 1, 3), [1, 3], 'Example 2');
is(check_order(3, 1, 3, 2, 3), [0, 1, 3], 'Example 3');
done_testing();

sub check_order
{
     my @arr = @_;
     my @sorted = sort {$a <=> $b} @arr;
     return [grep { $arr[$_] != $sorted[$_] } 0 .. $#arr];
}