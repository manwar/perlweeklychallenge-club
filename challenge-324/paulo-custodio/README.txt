Challenge 324
https://theweeklychallenge.org/blog/perl-weekly-challenge-324/

Task 1: 2D Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers and two integers $r amd $c.

Write a script to create two dimension array having $r rows and $c columns using the given array.


Example 1
Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
Output: ([1, 2], [3, 4])

Example 2
Input: @ints = (1, 2, 3), $r = 1, $c = 3
Output: ([1, 2, 3])

Example 3
Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
Output: ([1], [2], [3], [4])

Task 2: Total XOR
Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given array.


Example 1
Input: @ints = (1, 3)
Output: 6

Subset [1],    total XOR = 1
Subset [3],    total XOR = 3
Subset [1, 3], total XOR => 1 XOR 3 => 2

Sum of total XOR => 1 + 3 + 2 => 6

Example 2
Input: @ints = (5, 1, 6)
Output: 28

Subset [5],       total XOR = 5
Subset [1],       total XOR = 1
Subset [6],       total XOR = 6
Subset [5, 1],    total XOR => 5 XOR 1 => 4
Subset [5, 6],    total XOR => 5 XOR 6 => 3
Subset [1, 6],    total XOR => 1 XOR 6 => 7
Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example 3
Input: @ints = (3, 4, 5, 6, 7, 8)
Output: 480
