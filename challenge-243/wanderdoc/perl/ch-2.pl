#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers (>=1). Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.
Example 1
Input: @nums = (2, 5, 9)
Output: 10
floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1
Example 2
Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49

=cut

use Test2::V0;

sub floor_sum
{
     my @arr = @_;
     my $sum = 0;
     for my $i ( 0 .. $#arr )
     {
          for my $j ( 0 .. $#arr )
          {
               $sum += int($arr[$i]/$arr[$j]);
          }
     }
     return $sum;
}


is(floor_sum(2, 5, 9), 10, 'Example 1');
is(floor_sum(7, 7, 7, 7, 7, 7, 7), 49, 'Example 2');
done_testing();