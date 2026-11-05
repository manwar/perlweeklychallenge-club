#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers.

Write a script to return the closest integer to the mean value of all even integers that are divisible by 3. If none is divisible, return 0.
Example 1

Input: @arr = (18, 5, 7, 11)
Output: 18

18 is the only even number and divisible by 3.
Average: 18 / 1 = 18.

Example 2
Input: @arr = (6, 12, 18, 24, 30, 40)
Output: 18
The qualifying numbers are 6, 12, 18, 24, and 30.
Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18

Example 3
Input: @arr = (3, 9, 15, 21, 27)
Output: 0
None of the elements are even.
Since no elements qualify, return 0.

Example 4
Input: @arr = (6, 12, 14, 20)
Output: 9
The qualifying numbers are 6 and 12.
Average: (6 + 12) / 2 = 9.

Example 5

Input: @arr = (6, 6, 6, 12, 12)
Output: 8


All five numbers are even and divisible by 3.
Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8
=cut

use List::Util qw(sum);
use Test2::V0 - no_srand => 1;



is(custom_average(18, 5, 7, 11), 18, 'Example 1');
is(custom_average(6, 12, 18, 24, 30, 40), 18, 'Example 2');
is(custom_average(3, 9, 15, 21, 27), 0, 'Example 3');
is(custom_average(6, 12, 14, 20), 9, 'Example 4');
is(custom_average(6, 6, 6, 12, 12), 8, 'Example 5');
done_testing();

sub custom_average
{
     my @arr = @_;
     @arr = grep { $_ % 2 == 0 and $_ % 3 == 0 } @arr;
     my $count = scalar @arr;
     return 0 unless $count;
     my $avg = sum(@arr)/$count;
     my $lower = int($avg);

     if ($avg = $lower)
     {
          return $avg;
     }
     else
     {
          my $upper = int($avg + 0.5);
          if (( $avg - $lower ) < ($upper - $avg))
          {
               return $lower;
          }
          else
          {
               return $upper;
          }
     }
}
