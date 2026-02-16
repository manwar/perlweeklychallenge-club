Challenge 327
https://theweeklychallenge.org/blog/perl-weekly-challenge-327/

Task 1: Missing Integers
Submitted by: Mohammad Sajid Anwar
You are given an array of n integers.

Write a script to find all the missing integers in the range 1..n in the given array.


Example 1
Input: @ints = (1, 2, 1, 3, 2, 5)
Output: (4, 6)

The given array has 6 elements.
So we are looking for integers in the range 1..6 in the given array.
The missing integers: (4, 6)

Example 2
Input: @ints = (1, 1, 1)
Output: (2, 3)

Example 3
Input: @ints = (2, 2, 1)
Output: (3)

Task 2: MAD
Submitted by: Mohammad Sajid Anwar
You are given an array of distinct integers.

Write a script to find all pairs of elements with minimum absolute difference (MAD) of any two elements.


Example 1
Input: @ints = (4, 1, 2, 3)
Output: [1,2], [2,3], [3,4]

The minimum absolute difference is 1.
Pairs with MAD: [1,2], [2,3], [3,4]

Example 2
Input: @ints = (1, 3, 7, 11, 15)
Output: [1,3]

Example 3
Input: @ints = (1, 5, 3, 8)
Output: [1,3], [3,5]
