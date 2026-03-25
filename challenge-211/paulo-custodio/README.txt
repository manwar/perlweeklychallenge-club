Perl Weekly Challenge 211
https://theweeklychallenge.org/blog/perl-weekly-challenge-211/

Task 1: Toeplitz Matrix
Submitted by: Mohammad S Anwar
You are given a matrix m x n.

Write a script to find out if the given matrix is Toeplitz Matrix.

A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.


Example 1
Input: @matrix = [ [4, 3, 2, 1],
                   [5, 4, 3, 2],
                   [6, 5, 4, 3],
                 ]
Output: true

Example 2
Input: @matrix = [ [1, 2, 3],
                   [3, 2, 1],
                 ]
Output: false


Task 2: Split Same Average
Submitted by: Mohammad S Anwar
You are given an array of integers.

Write a script to find out if the given can be split into two separate arrays whose average are the same.

Example 1:
Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
Output: true

We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
The average of the two arrays are the same i.e. 4.5.

Example 2:
Input: @list = (1, 3)
Output: false
