Challenge 298
https://theweeklychallenge.org/blog/perl-weekly-challenge-298/

Task 1: Maximal Square
Submitted by: Mohammad Sajid Anwar
You are given an m x n binary matrix with 0 and 1 only.

Write a script to find the largest square containing only 1's and return it’s area.

Example 1
Input: @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0])
Output: 4

Two maximal square found with same size marked as 'x':

[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]
Example 2
Input: @matrix = ([0, 1],
                  [1, 0])
Output: 1

Two maximal square found with same size marked as 'x':

[0, x]
[1, 0]


[0, 1]
[x, 0]
Example 3
Input: @matrix = ([0])
Output: 0

Task 2: Right Interval
Submitted by: Mohammad Sajid Anwar
You are given an array of @intervals, where $intervals[i] = [starti, endi] and each starti is unique.

The right interval for an interval i is an interval j such that startj >= endi and startj is minimized. Please note that i may equal j.

Write a script to return an array of right interval indices for each interval i. If no right interval exists for interval i, then put -1 at index i.

Example 1
Input: @intervals = ([3,4], [2,3], [1,2])
Output: (-1, 0, 1)

There is no right interval for [3,4].
The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start that is >= end1 = 3.
The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start that is >= end2 = 2.
Example 2
Input: @intervals = ([1,4], [2,3], [3,4])
Output: (-1, 2, -1)

There is no right interval for [1,4] and [3,4].
The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start that is >= end1 = 3.
Example 3
Input: @intervals = ([1,2])
Output: (-1)

There is only one interval in the collection, so it outputs -1.
Example 4
Input: @intervals = ([1,4], [2, 2], [3, 4])
Output: (-1, 1, -1)
