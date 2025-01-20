#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints and an integer, $n which is less than or equal to total elements in the given array.

Write a script to find the contiguous subarray whose length is the given integer, $n, and has the maximum average. It should return the average.
Example 1

Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
Output: 12.75

Subarray: (12, -5, -6, 50)
Average: (12 - 5 - 6 + 50) / 4 = 12.75

Example 2

Input: @ints = (5), $n = 1
Output: 5
=cut

use List::Util qw(sum);
use Test2::V0 -no_srand => 1;

is(maximal_average([1, 12, -5, -6, 50, 3], 4), 12.75, 'Example 1');
is(maximal_average([5], 1), 5, 'Example 2');
done_testing();


sub maximal_average
{
     my ($aref, $n) = @_;
     die "Illegal length!" if ($n < 1 or $n > $#$aref + 1 );
     my $max_sum = 0;
     for my $idx ( 0 .. $#$aref - $n  + 1)
     {
          my $sliding_sum = sum(@{$aref}[$idx .. $idx + $n - 1]);
          if ( $sliding_sum > $max_sum )
          {
               $max_sum = $sliding_sum;
          }
     }
     return $max_sum / $n;
}