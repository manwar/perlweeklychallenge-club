Challenge 334
https://theweeklychallenge.org/blog/perl-weekly-challenge-334/

Task 1: Range Sum
Submitted by: Mohammad Sajid Anwar
You are given a list integers and pair of indices..

Write a script to return the sum of integers between the given indices (inclusive).


Example 1
Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
Output: 1

Elements between indices (0, 2) => (-2, 0, 3)
Range Sum: (-2) + 0 + 3 => 1

Example 2
Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
Output: -3

Elements between indices (1, 3) => (-2, 3, -4)
Range Sum: (-2) + 3 + (-4) => -3

Example 3
Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
Output: 2

Elements between indices (3, 4) => (-1, 3)
Range Sum: (-1) + 3 => 2

Example 4
Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
Output: -2

Elements between indices (0, 3) => (-5, 4, -3, 2)
Range Sum: (-5) + 4 + (-3) + 2 => -2

Example 5
Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
Output: 1

Elements between indices (0, 2) => (-1, 0, 2)
Range Sum: (-1) + 0 + 2 => 1

Task 2: Nearest Valid Point
Submitted by: Mohammad Sajid Anwar
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
