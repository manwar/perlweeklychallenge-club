Challenge 306
https://theweeklychallenge.org/blog/perl-weekly-challenge-306/

Task 1: Odd Sum
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers, @ints.

Write a script to return the sum of all possible odd-length subarrays of the given array. A subarray is a contiguous subsequence of the array.

Example 1
Input: @ints = (2, 5, 3, 6, 4)
Output: 77

Odd length sub-arrays:
(2) => 2
(5) => 5
(3) => 3
(6) => 6
(4) => 4
(2, 5, 3) => 10
(5, 3, 6) => 14
(3, 6, 4) => 13
(2, 5, 3, 6, 4) => 20

Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77
Example 2
Input: @ints = (1, 3)
Output: 4

Task 2: Last Element
Submitted by: Mohammad Sajid Anwar
You are given a array of integers, @ints.

Write a script to play a game where you pick two biggest integers in the given array, say x and y. Then do the following:

a) if x == y then remove both from the given array
b) if x != y then remove x and replace y with (y - x)
At the end of the game, there is at most one element left.

Return the last element if found otherwise return 0.

Example 1
Input: @ints = (3, 8, 5, 2, 9, 2)
Output: 1

Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
Step 2: pick 3 and 5 => (2, 2, 1, 2)
Step 3: pick 2 and 1 => (1, 2, 2)
Step 4: pick 2 and 1 => (1, 2)
Step 5: pick 1 and 2 => (1)
Example 2
Input: @ints = (3, 2, 5)
Output: 0

Step 1: pick 3 and 5 => (2, 2)
Step 2: pick 2 and 2 => ()
