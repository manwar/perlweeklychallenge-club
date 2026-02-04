Challenge 351
https://theweeklychallenge.org/blog/perl-weekly-challenge-351/

Task 1: Special Average
Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the given array.

Example 1
Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
Output: 5250

Min: 2000
Max: 8000
Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2
Input: @ints = (100_000, 80_000, 110_000, 90_000)
Output: 95_000

Min: 80_000
Max: 110_000
Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3
Input: @ints = (2500, 2500, 2500, 2500)
Output: 0

Min: 2500
Max: 2500
Avg: 0

Example 4
Input: @ints = (2000)
Output: 0

Min: 2000
Max: 2000
Avg: 0

Example 5
Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
Output: 3500

Min: 1000
Max: 6000
Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

Task 2: Arithmetic Progression
Submitted by: Mohammad Sajid Anwar
You are given an array of numbers.

Write a script to return true if the given array can be re-arranged to form an arithmetic progression, otherwise return false.

A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.


Example 1
Input: @num = (1, 3, 5, 7, 9)
Output: true

Already AP with common difference 2.

Example 2
Input: @num = (9, 1, 7, 5, 3)
Output: true

The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

Example 3
Input: @num = (1, 2, 4, 8, 16)
Output: false

This is geometric progression and not arithmetic progression.

Example 4
Input: @num = (5, -1, 3, 1, -3)
Output: true

The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.

Example 5
Input: @num = (1.5, 3, 0, 4.5, 6)
Output: true

The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
