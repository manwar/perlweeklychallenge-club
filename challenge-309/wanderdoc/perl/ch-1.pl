#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints, increasing order.

Write a script to return the element before which you find the smallest gap.
Example 1

Input: @ints = (2, 8, 10, 11, 15)
Output: 11

8  - 2  => 6
10 - 8  => 2
11 - 10 => 1
15 - 11 => 4

11 is where we found the min gap.

Example 2

Input: @ints = (1, 5, 6, 7, 14)
Output: 6

5  - 1 => 4
6  - 5 => 1
7  - 6 => 1
14 - 7 => 7

6 and 7 where we found the min gap, so we pick the first instance.

Example 3

Input: @ints = (8, 20, 25, 28)
Output: 28

8  - 20 => 14
25 - 20 => 5
28 - 25 => 3

28 is where we found the min gap.
=cut


use POSIX qw(INT_MAX);
use Test2::V0 -no_srand => 1;



is(min_gap(2, 8, 10, 11, 15), 11, 'Example 1');
is(min_gap(1, 5, 6, 7, 14), 6, 'Example 2');
is(min_gap(8, 20, 25, 28), 28, 'Example 3');

done_testing();

sub min_gap
{
     my @arr = @_;
     my $min = INT_MAX;
     my $elm_gap;
     for my $idx ( 0 .. $#arr - 1 )
     {
          if ( ($arr[$idx+1]-$arr[$idx]) < $min )
          {
               $min = $arr[$idx+1]-$arr[$idx];
               $elm_gap = $arr[$idx+1];
          }
     }
     return $elm_gap;
}