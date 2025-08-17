#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given current location as two integers: x and y. You are also given a list of points on the grid.

A point is considered valid if it shares either the same x-coordinate or the same y-coordinate as the current location.

Write a script to return the index of the valid point that has the smallest Manhattan distance to the current location. If multiple valid points are tied for the smallest distance, return the one with the lowest index. If no valid points exist, return -1.

    The Manhattan distance between two points (x1, y1) and (x2, y2) is calculated as: |x1 - x2| + |y1 - y2|


Example 1

Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
Output: 2

Valid points: [3, 1] (same x), [2, 4] (same y)

Manhattan distances:
    [3, 1] => |3-3| + |4-1| = 3
    [2, 4] => |3-2| + |4-4| = 1

Closest valid point is [2, 4] at index 2.


Example 2

Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
Output: 3

Valid points: [2, 3], [1, 5], [2, 5]

Manhattan distances:
    [2, 3] => 2
    [1, 5] => 1
    [2, 5] => 0

Closest valid point is [2, 5] at index 3.


Example 3

Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
Output: -1

No point shares x or y with (1, 1).


Example 4

Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
Output: 0

Valid points: all of them

Manhattan distances:
    [0, 1] => 1
    [1, 0] => 1
    [0, 2] => 2
    [2, 0] => 2

Tie between index 0 and 1, pick the smaller index: 0


Example 5

Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
Output: 0

Valid points: all of them
    [5, 6] => 1
    [6, 5] => 1
    [5, 4] => 1
    [4, 5] => 1

All tie, return the one with the lowest index: 0
=cut






use Test2::V0 -no_srand => 1;
is(nearest_valid_point(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]), 2, 'Example 1');
is(nearest_valid_point(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]), 3, 'Example 2');
is(nearest_valid_point(1, 1, [[2, 2], [3, 3], [4, 4]]),        -1, 'Example 3');
is(nearest_valid_point(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]), 0, 'Example 4');
is(nearest_valid_point(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]), 0, 'Example 5');
done_testing();

sub nearest_valid_point
{
     my ($x, $y, $grid) = @_;
     my @nearest =
          sort { $a->[0] <=> $b->[0] or $a->[1] <=> $b->[1] }
          map {[manhattan_distance($grid->[$_][0], $grid->[$_][1], $x, $y), $_] }
          grep { is_valid_point($grid->[$_][0], $grid->[$_][1], $x, $y) } 
          0 .. $#$grid;
     return scalar @nearest ? $nearest[0][1] : -1;
}


sub is_valid_point
{
     my ($x1, $y1, $x2, $y2) = @_;
     return (($x1 == $x2) or ($y1 == $y2));
}


sub manhattan_distance
{
     my ($x1, $y1, $x2, $y2) = @_;
     return abs($x1 - $x2) + abs($y1 - $y2);
}
