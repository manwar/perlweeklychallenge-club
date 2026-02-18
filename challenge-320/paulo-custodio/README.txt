Challenge 320
https://theweeklychallenge.org/blog/perl-weekly-challenge-320/

Task 1: Maximum Count
Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return the maximum between the number of positive and negative integers. Zero is neither positive nor negative.


Example 1
Input: @ints = (-3, -2, -1, 1, 2, 3)
Output: 3

There are 3 positive integers.
There are 3 negative integers.
The maximum between 3 and 3 is 3.

Example 2
Input: @ints = (-2, -1, 0, 0, 1)
Output: 2

There are 1 positive integers.
There are 2 negative integers.
The maximum between 2 and 1 is 2.

Example 3
Input: @ints = (1, 2, 3, 4)
Output: 4

There are 4 positive integers.
There are 0 negative integers.
The maximum between 4 and 0 is 4.

Task 2: Sum Difference
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and element sum of the given array.


Example 1
Input: @ints = (1, 23, 4, 5)
Output: 18

Element sum: 1 + 23 + 4 + 5 => 33
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 33 - 15 | => 18

Example 2
Input: @ints = (1, 2, 3, 4, 5)
Output: 0

Element sum: 1 + 2 + 3 + 4 + 5 => 15
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 15 - 15 | => 0

Example 3
Input: @ints = (1, 2, 34)
Output: 27

Element sum: 1 + 2 + 34 => 37
Digit sum: 1 + 2 + 3 + 4 => 10
Absolute difference: | 37 - 10 | => 27
