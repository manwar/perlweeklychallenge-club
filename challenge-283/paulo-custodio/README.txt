Perl Weekly Challenge 283
https://theweeklychallenge.org/blog/perl-weekly-challenge-283/

Task 1: Unique Number
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, where every elements appears more than once except one element.

Write a script to find the one element that appears exactly one time.

Example 1
Input: @ints = (3, 3, 1)
Output: 1
Example 2
Input: @ints = (3, 2, 4, 2, 4)
Output: 3
Example 3
Input: @ints = (1)
Output: 1
Example 4
Input: @ints = (4, 3, 1, 1, 1, 4)
Output: 3

Task 2: Digit Count Value
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range 0 <= i < size of array, the digit i occurs exactly the $ints[$i] times in the given array otherwise return false.

Example 1
Input: @ints = (1, 2, 1, 0)
Ouput: true

$ints[0] = 1, the digit 0 occurs exactly 1 time.
$ints[1] = 2, the digit 1 occurs exactly 2 times.
$ints[2] = 1, the digit 2 occurs exactly 1 time.
$ints[3] = 0, the digit 3 occurs 0 time.
Example 2
Input: @ints = (0, 3, 0)
Ouput: false

$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
$ints[2] = 0, the digit 2 occurs exactly 0 time.
