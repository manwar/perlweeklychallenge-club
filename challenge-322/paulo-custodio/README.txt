Challenge 322
https://theweeklychallenge.org/blog/perl-weekly-challenge-322/

Task 1: String Format
Submitted by: Mohammad Sajid Anwar
You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of size given by the integer. The first group can be smaller than the integer but should have at least one character. Groups should be separated by dashes.


Example 1
Input: $str = "ABC-D-E-F", $i = 3
Output: "ABC-DEF"

Example 2
Input: $str = "A-BC-D-E", $i = 2
Output: "A-BC-DE"

Example 3
Input: $str = "-A-B-CD-E", $i = 4
Output: "A-BCDE"

Task 2: Rank Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return an array of the ranks of each element: the lowest value has rank 1, next lowest rank 2, etc. If two elements are the same then they share the same rank.


Example 1
Input: @ints = (55, 22, 44, 33)
Output: (4, 1, 3, 2)

Example 2
Input: @ints = (10, 10, 10)
Output: (1, 1, 1)

Example 3
Input: @ints = (5, 1, 1, 4, 3)
Output: (4, 1, 1, 3, 2)
