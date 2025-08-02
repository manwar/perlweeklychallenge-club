#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints. Write a script to evaluate the absolute difference between element and digit sum of the given array.

Example 1 Input: @ints = (1,2,3,45) Output: 36

Element Sum: 1 + 2 + 3 + 45 = 51
Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
Absolute Difference: | 51 - 15 | = 36

Example 2 Input: @ints = (1,12,3) Output: 9

Element Sum: 1 + 12 + 3 = 16
Digit Sum: 1 + 1 + 2 + 3 = 7
Absolute Difference: | 16 - 7 | = 9

Example 3 Input: @ints = (1,2,3,4) Output: 0

Element Sum: 1 + 2 + 3 + 4 = 10
Digit Sum: 1 + 2 + 3 + 4 = 10
Absolute Difference: | 10 - 10 | = 0

Example 4

Input: @ints = (236, 416, 336, 350) Output: 1296
=cut


use List::Util qw(sum);
use Test2::V0;

is(sum_diff(1,2,3,45), 36, 'Example 1');
is(sum_diff(1,12,3), 9, 'Example 2');
is(sum_diff(1,2,3,4), 0, 'Example 3');
is(sum_diff(236, 416, 336, 350), 1296, 'Example 4');


done_testing();

sub sum_diff
{
     my @arr = @_;
     my $elm_sum = sum(@arr);
     my $dig_sum = sum(map digit_sum($_), @arr); 
     my $diff = abs($elm_sum - $dig_sum);
     return $diff;
     
}

sub digit_sum
{
     my $num = $_[0];
     my @arr = split(//, $num);
     my $sum = sum(@arr);
     return $sum;
}