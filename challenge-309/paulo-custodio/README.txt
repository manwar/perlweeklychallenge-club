Challenge 309
https://theweeklychallenge.org/blog/perl-weekly-challenge-309/

Task 1: Min Gap
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, increasing order.

Write a script to return the element before which you find the smallest gap.

Example 1
Input: @ints = (2, 8, 10, 11, 15)
Output: 11

 8 - 2  => 6
10 - 8  => 2
11 - 10 => 1
15 - 11 => 4

11 is where we found the min gap.
Example 2
Input: @ints = (1, 5, 6, 7, 14)
Output: 6

 5 - 1 => 4
 6 - 5 => 1
 7 - 6 => 1
14 - 7 => 7

6 and 7 where we found the min gap, so we pick the first instance.
Example 3
Input: @ints = (8, 20, 25, 28)
Output: 28

 8 - 20 => 14
25 - 20 => 5
28 - 25 => 3

28 is where we found the min gap.

Task 2: Min Diff
Submitted by: Mohammad Sajid Anwar
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
