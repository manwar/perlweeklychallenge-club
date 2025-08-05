#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of co-ordinates.
Write a script to find out if the given points make a straight line.

Example 1

Input: @list = ([2, 1], [2, 3], [2, 5])
Output: true


Example 2

Input: @list = ([1, 4], [3, 4], [10, 4])
Output: true


Example 3

Input: @list = ([0, 0], [1, 1], [2, 3])
Output: false


Example 4

Input: @list = ([1, 1], [1, 1], [1, 1])
Output: true


Example 5

Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
Output: true
=cut



use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(is_straight_line([2, 1], [2, 3], [2, 6]), true, 'Example 1');
is(is_straight_line([1, 4], [3, 4], [10, 4]), true, 'Example 2');
is(is_straight_line([0, 0], [1, 1], [2, 3]), false, 'Example 3');
is(is_straight_line([1, 1], [1, 1], [1, 1]), true, 'Example 4');
is(is_straight_line([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]), true, 'Example 5');
done_testing();

sub is_straight_line
{
     my @arr = @_;
     return 
          (
               ($arr[0][0] == $arr[1][0] and $arr[0][0] == $arr[2][0])
               or
               ($arr[0][1] == $arr[1][1] and $arr[0][1] == $arr[2][1])
               or
               (
               (($arr[1][0] - $arr[0][0]) == ($arr[2][0] - $arr[1][0]))
                    and
               (($arr[1][1] - $arr[0][1]) == ($arr[2][1] - $arr[1][1]))
               )
          )
          ? true
          : false;
}
