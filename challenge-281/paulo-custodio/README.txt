Perl Weekly Challenge 281
https://theweeklychallenge.org/blog/perl-weekly-challenge-281/

Task 1: Check Color
Submitted by: Mohammad Sajid Anwar
You are given coordinates, a string that represents the coordinates of a square of the chessboard as shown below:

Week_281_Task_1

Write a script to return true if the square is light, and false if the square is dark.

Example 1
Input: $coordinates = "d3"
Output: true
Example 2
Input: $coordinates = "g5"
Output: false
Example 3
Input: $coordinates = "e6"
Output: true

Task 2: Knight’s Move
Submitted by: Peter Campbell Smith
A Knight in chess can move from its current position to any square two rows or columns plus one column or row away. So in the diagram below, if it starts a S, it can move to any of the squares marked E.

Write a script which takes a starting position and an ending position and calculates the least number of moves required.

Week_281_Task_2

Example 1
Input: $start = 'g2', $end = 'a8'
Ouput: 4

g2 -> e3 -> d5 -> c7 -> a8
Example 2
Input: $start = 'g2', $end = 'h2'
Ouput: 3

g2 -> e3 -> f1 -> h2
