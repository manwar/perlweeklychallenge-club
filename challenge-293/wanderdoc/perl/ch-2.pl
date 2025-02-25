#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

A boomerang is a set of three points that are all distinct and not in a straight line.

Example 1

Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true

Example 2

Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false

Example 3

Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true

Example 4

Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false

Example 5

Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false

Example 6

Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true

=cut


use constant { true => 1, false => 0 };

use Test2::V0;


is(is_boomerang([1, 1], [2, 3], [3, 2]), true, 'Example 1');
is(is_boomerang([1, 1], [2, 2], [3, 3]), false, 'Example 2');
is(is_boomerang([1, 1], [1, 2], [2, 3]), true, 'Example 3');
is(is_boomerang([1, 1], [1, 2], [1, 3]), false, 'Example 4');
is(is_boomerang([1, 1], [2, 1], [3, 1]), false, 'Example 5');
is(is_boomerang([0, 0], [2, 3], [4, 5]), true, 'Example 6');
is(is_boomerang([-3, -3], [-1, 1], [1, 5]), false, 'Example 7');
is(is_boomerang([-3, -3], [-1, -2], [3, -1]), true, 'Example 8');


done_testing();

sub is_boomerang
{
     my @arr = @_;
     return 
          (
          (($arr[1][0] - $arr[0][0]) == ($arr[2][0] - $arr[1][0]))
               and
          (($arr[1][1] - $arr[0][1]) == ($arr[2][1] - $arr[1][1]))
          )
          ? false
          : true;
}