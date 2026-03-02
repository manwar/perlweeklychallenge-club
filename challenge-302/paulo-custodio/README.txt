Challenge 302
https://theweeklychallenge.org/blog/perl-weekly-challenge-302/

Task 1: Ones and Zeroes
Submitted by: Mohammad Sajid Anwar
You are given an array of binary strings, @str, and two integers, $x and $y.

Write a script to return the size of the largest subset of @str such that there are at most $x 0’s and $y 1’s in the subset.

A set m is a subset of n if all elements of m are also elements of n.
Example 1
Input: @str = ("10", "0001", "111001", "1", "0")
       $x = 5
       $y = 3
Output: 4

The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")
Example 2
Input: @str = ("10", "1", "0")
       $x = 1
       $y = 1
Output: 2

The largest subset with at most one 0's and one 1's:
("1", "0")

Task 2: Step by Step
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the minimum positive start value such that step by step sum is never less than one.

Example 1
Input: @ints = (-3, 2, -3, 4, 2)
Output: 5

For start value 5.
5 + (-3) = 2
2 + (+2) = 4
4 + (-3) = 1
1 + (+4) = 5
5 + (+2) = 7
Example 2
Input: @ints = (1, 2)
Output: 1
Example 3
Input: @ints = (1, -2, -3)
Output: 5
