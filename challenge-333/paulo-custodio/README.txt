Challenge 333
https://theweeklychallenge.org/blog/perl-weekly-challenge-333/

Task 1: Straight Line
Submitted by: Mohammad Sajid Anwar
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

Task 2: Duplicate Zeros
Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to duplicate each occurrence of zero, shifting the remaining elements to the right. The elements beyond the length of the original array are not written.


Example 1
Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Output: (1, 0, 0, 2, 3, 0, 0, 4)

Each zero is duplicated.
Elements beyond the original length (like 5 and last 0) are discarded.

Example 2
Input: @ints = (1, 2, 3)
Output: (1, 2, 3)

No zeros exist, so the array remains unchanged.

Example 3
Input: @ints = (1, 2, 3, 0)
Output: (1, 2, 3, 0)

Example 4
Input: @ints = (0, 0, 1, 2)
Output: (0, 0, 0, 0)

Example 5
Input: @ints = (1, 2, 0, 3, 4)
Output: (1, 2, 0, 0, 3)
