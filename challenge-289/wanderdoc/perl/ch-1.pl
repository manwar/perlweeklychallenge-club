#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to find the third distinct maximum in the given array. If third maximum doesn’t exist then return the maximum number.
Example 1

Input: @ints = (5, 6, 4, 1)
Output: 4

The first distinct maximum is 6.
The second distinct maximum is 5.
The third distinct maximum is 4.

Example 2

Input: @ints = (4, 5)
Output: 5

In the given array, the third maximum doesn't exist therefore returns the maximum.

Example 3

Input: @ints =  (1, 2, 2, 3)
Output: 1

The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.

=cut


use Test2::V0;



is(third_max(5, 6, 4, 1), 4, 'Example 1');
is(third_max(4, 5),       5, 'Example 2');
is(third_max(1, 2, 2, 3), 1, 'Example 3');
done_testing();

sub third_max
{
     my @arr = @_;
     my %seen;
     @arr = grep {!$seen{$_}++}  sort {$b <=> $a} @arr;
     return scalar @arr > 2 ? $arr[2] : $arr[0];
}