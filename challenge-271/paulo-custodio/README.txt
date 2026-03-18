Perl Weekly Challenge 271
https://theweeklychallenge.org/blog/perl-weekly-challenge-271/

Task 1: Maximum Ones
Submitted by: Mohammad Sajid Anwar
You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.

Example 1
Input: $matrix = [ [0, 1],
                   [1, 0],
                 ]
Output: 1

Row 1 and Row 2 have the same number of ones, so return row 1.
Example 2
Input: $matrix = [ [0, 0, 0],
                   [1, 0, 1],
                 ]
Output: 2

Row 2 has the maximum ones, so return row 2.
Example 3
Input: $matrix = [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ]
Output: 2

Row 2 have the maximum ones, so return row 2.

Task 2: Sort by 1 bits
Submitted by: Mohammad Sajid Anwar
You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.

Example 1
Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

0 = 0 one bits
1 = 1 one bits
2 = 1 one bits
4 = 1 one bits
8 = 1 one bits
3 = 2 one bits
5 = 2 one bits
6 = 2 one bits
7 = 3 one bits
Example 2
Input: @ints = (1024, 512, 256, 128, 64)
Output: (64, 128, 256, 512, 1024)

All integers in the given array have one 1-bits, so just sort them in ascending order.
