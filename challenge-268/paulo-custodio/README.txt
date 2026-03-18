Perl Weekly Challenge 268
https://theweeklychallenge.org/blog/perl-weekly-challenge-268/

Task 1: Magic Number
Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each elements of one of the array gives the second array. Elements order is not important.

Example 1
Input: @x = (3, 7, 5)
       @y = (9, 5, 7)
Output: 2

The magic number is 2.
@x = (3, 7, 5)
   +  2  2  2
@y = (5, 9, 7)
Example 2
Input: @x = (1, 2, 1)
       @y = (5, 4, 4)
Output: 3

The magic number is 3.
@x = (1, 2, 1)
   +  3  3  3
@y = (5, 4, 4)
Example 3
Input: @x = (2)
       @y = (5)
Output: 3

Task 2: Number Game
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given array. Pick the two smallest integers and add it to new array in decreasing order i.e. high to low. Keep doing until the given array is empty.

Example 1
Input: @ints = (2, 5, 3, 4)
Output: (3, 2, 5, 4)

Round 1: we picked (2, 3) and push it to the new array (3, 2)
Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)
Example 2
Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
Output: (1, 1, 4, 3, 6, 4, 9, 6)
Example 3
Input: @ints = (1, 2, 2, 3)
Output: (2, 1, 3, 2)
