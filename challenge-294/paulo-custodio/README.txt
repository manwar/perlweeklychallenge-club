Challenge 294
https://theweeklychallenge.org/blog/perl-weekly-challenge-294/

Task 1: Consecutive Sequence
Submitted by: Mohammad Sajid Anwar
You are given an unsorted array of integers, @ints.

Write a script to return the length of the longest consecutive elements sequence. Return -1 if none found. The algorithm must runs in O(n) time.

Example 1
Input: @ints = (10, 4, 20, 1, 3, 2)
Output: 4

The longest consecutive sequence (1, 2, 3, 4).
The length of the sequence is 4.
Example 2
Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
Output: 9
Example 3
Input: @ints = (10, 30, 20)
Output: -1

Task 2: Next Permutation
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find out the next permutation of the given array.

The next permutation of an array of integers is the next lexicographically greater permutation of its integer.

Example 1
Input: @ints = (1, 2, 3)
Output: (1, 3, 2)

Permutations of (1, 2, 3) arranged lexicographically:
(1, 2, 3)
(1, 3, 2)
(2, 1, 3)
(2, 3, 1)
(3, 1, 2)
(3, 2, 1)
Example 2
Input: @ints = (2, 1, 3)
Output: (2, 3, 1)
Example 3
Input: @ints = (3, 1, 2)
Output: (3, 2, 1)
