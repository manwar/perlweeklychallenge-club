#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.
Write a script to find the minimum positive start value such that step by step sum is never less than one.
Example 1
Input: @ints = (-3, 2, -3, 4, 2)
Output: 5
For start value 5.
5 + (-3) = 2
2 + (+2) = 4
4 + (-3) = 1
1 + (+4) = 5
5 + (+2) = 7
Example 2
Input: @ints = (1, 2)
Output: 1
Example 3
Input: @ints = (1, -2, -3)
Output: 5
=cut

use List::Util qw(min);
use Test2::V0 -no_srand => 1;

is(array_sum(-3, 2, -3, 4, 2), 5, 'Example 1');
is(array_sum(1, 2), 1, 'Example 2');
is(array_sum(1, -2, -3), 5, 'Example 3');
done_testing();

sub array_sum 
{
     my @arr = @_;
     my $start_value = 1; # minimum positive start value
     my $cum_sum = $start_value; 
     my $min_cum_sum = $start_value;


     for my $elm (@arr) 
     {
          $cum_sum += $elm;
          $min_cum_sum = min($min_cum_sum, $cum_sum);
     }

     my $adjust = $min_cum_sum < 1 ? 1 - $min_cum_sum : 0;

     return $start_value + $adjust;
}