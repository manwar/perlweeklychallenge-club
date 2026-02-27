Challenge 293
https://theweeklychallenge.org/blog/perl-weekly-challenge-293/

Task 1: Similar Dominos
Submitted by: Mohammad Sajid Anwar
You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other domino.

$dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).

Example 1
Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Output: 2

Similar Dominos: $dominos[0], $dominos[1]
Example 2
Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Output: 3

Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

Task 2: Boomerang
Submitted by: Mohammad Sajid Anwar
You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

A boomerang is a set of three points that are all distinct and not in a straight line.

Example 1
Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true
Example 2
Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false
Example 3
Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true
Example 4
Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false
Example 5
Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false
Example 6
Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true
