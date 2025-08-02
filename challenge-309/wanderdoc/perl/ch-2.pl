#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to find the minimum difference between any two elements.
Example 1

Input: @ints = (1, 5, 8, 9)
Output: 1

1, 5 => 5 - 1 => 4
1, 8 => 8 - 1 => 7
1, 9 => 9 - 1 => 8
5, 8 => 8 - 5 => 3
5, 9 => 9 - 5 => 4
8, 9 => 9 - 8 => 1

Example 2

Input: @ints = (9, 4, 1, 7)
Output: 2

9, 4 => 9 - 4 => 5
9, 1 => 9 - 1 => 8
9, 7 => 9 - 7 => 2
4, 1 => 4 - 1 => 3
4, 7 => 7 - 4 => 3
1, 7 => 7 - 1 => 6
=cut


use POSIX qw(INT_MAX);
use Test2::V0 -no_srand => 1;




is(min_diff(1, 5, 8, 9), 1, 'Example 1');
is(min_diff(9, 4, 1, 7), 2, 'Example 2');
done_testing();

sub min_diff
{
     my @arr = @_;
     @arr = sort {$b <=> $a} @arr;
     my $min = INT_MAX;
     for my $idx ( 0 .. $#arr - 1 )
     {
          $min = ($arr[$idx]-$arr[$idx+1]) < $min ?
                    ($arr[$idx]-$arr[$idx+1]) : $min;
     }
     return $min;
}