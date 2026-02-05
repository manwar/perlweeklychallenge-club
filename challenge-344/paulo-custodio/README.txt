Challenge 344
https://theweeklychallenge.org/blog/perl-weekly-challenge-344/

Task 1: Array Form Compute
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints and an integer, $x.

Write a script to add $x to the integer in the array-form.

The array form of an integer is a digit-by-digit representation stored as an array, where the most significant digit is at the 0th index.


Example 1
Input: @ints = (1, 2, 3, 4), $x = 12
Output: (1, 2, 4, 6)

Example 2
Input: @ints = (2, 7, 4), $x = 181
Output: (4, 5, 5)

Example 3
Input: @ints = (9, 9, 9), $x = 1
Output: (1, 0, 0, 0)

Example 4
Input: @ints = (1, 0, 0, 0, 0), $x = 9999
Output: (1, 9, 9, 9, 9)

Example 5
Input: @ints = (0), $x = 1000
Output: (1, 0, 0, 0)

Task 2: Array Formation
Submitted by: Mohammad Sajid Anwar
You are given two list: @source and @target.

Write a script to see if you can build the exact @target by putting these smaller lists from @source together in some order. You cannot break apart or change the order inside any of the smaller lists in @source.


Example 1
Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true

Use in the order: [1], [2,3], [4]

Example 2
Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3
Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true

Use in the order: [5,8], [2], [9,1]

Example 4
Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false

Missing number: 2

Example 5
Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true

Use in the order: [7, 4, 6]
