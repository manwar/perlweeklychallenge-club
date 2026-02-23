Challenge 304
https://theweeklychallenge.org/blog/perl-weekly-challenge-304/

Task 1: Arrange Binary
Submitted by: Mohammad Sajid Anwar
You are given a list of binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at least $n digits with 1 in the given list so that no two consecutive digits are 1 otherwise return false.

Example 1
Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true

Re-arranged list: (1, 0, 1, 0, 1)
Example 2
Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false

Task 2: Maximum Average
Submitted by: Mohammad Sajid Anwar
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
