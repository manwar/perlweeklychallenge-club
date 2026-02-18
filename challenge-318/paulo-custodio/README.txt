Challenge 318
https://theweeklychallenge.org/blog/perl-weekly-challenge-318/

Task 1: Group Position
Submitted by: Mohammad Sajid Anwar
You are given a string of lowercase letters.

Write a script to find the position of all groups in the given string. Three or more consecutive letters form a group. Return "” if none found.


Example 1
Input: $str = "abccccd"
Output: "cccc"

Example 2
Input: $str = "aaabcddddeefff"
Output: "aaa", "dddd", "fff"

Example 3
Input: $str = "abcdd"
Output: ""

Task 2: Reverse Equals
Submitted by: Roger Bell_West
You are given two arrays of integers, each containing the same elements as the other.

Write a script to return true if one array can be made to equal the other by reversing exactly one contiguous subarray.


Example 1
Input: @source = (3, 2, 1, 4)
       @target = (1, 2, 3, 4)
Output: true

Reverse elements: 0-2

Example 2
Input: @source = (1, 3, 4)
       @target = (4, 1, 3)
Output: false

Example 3
Input: @source = (2)
       @target = (2)
Output: true
