#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to find the lucky integer if found otherwise return -1. If there are more than one then return the largest.

    A lucky integer is an integer that has a frequency in the array equal to its value.

Example 1

Input: @ints = (2, 2, 3, 4)
Output: 2

Example 2

Input: @ints = (1, 2, 2, 3, 3, 3)
Output: 3

Example 3

Input: @ints = (1, 1, 1, 3)
Output: -1


=cut

use Test2::V0;

is(find_lucky_int(2, 2, 3, 4), 2, 'Example 1');
is(find_lucky_int(1, 2, 2, 3, 3, 3), 3, 'Example 2');
is(find_lucky_int(1, 1, 1, 3), -1, 'Example 3');
done_testing();


sub find_lucky_int
{
     my @arr = @_;
     my %freq;
     $freq{$_}++ for @arr;
     my @output = sort { $b <=> $a } grep { $freq{$_} == $_ } @arr;
     return $output[0] // -1;
}