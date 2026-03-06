Challenge 267
https://theweeklychallenge.org/blog/perl-weekly-challenge-267/

Task 1: Product Sign
Submitted by: Mohammad Sajid Anwar
You are given an array of @ints.

Write a script to find the sign of product of all integers in the given array. The sign is 1 if the product is positive, -1 if the product is negative and 0 if product is zero.

Example 1
Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
Output: 1

The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0
Example 2
Input: @ints = (1, 2, 0, -2, -1)
Output: 0

The product 1 x 2 x 0 x -2 x -1 => 0
Example 3
Input: @ints = (-1, -1, 1, -1, 2)
Output: -1

The product -1 x -1 x 1 x -1 x 2 => -2 < 0

Task 2: Line Counts
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, and a 26-items array @widths containing the width of each character from a to z.

Write a script to find out the number of lines and the width of the last line needed to display the given string, assuming you can only fit 100 width units on a line.

Example 1
Input: $str = "abcdefghijklmnopqrstuvwxyz"
       @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
Output: (3, 60)

Line 1: abcdefghij (100 pixels)
Line 2: klmnopqrst (100 pixels)
Line 3: uvwxyz (60 pixels)
Example 2
Input: $str = "bbbcccdddaaa"
       @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
Output: (2, 4)

Line 1: bbbcccdddaa (98 pixels)
Line 2: a (4 pixels)
