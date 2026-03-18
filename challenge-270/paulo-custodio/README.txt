Perl Weekly Challenge 270
https://theweeklychallenge.org/blog/perl-weekly-challenge-270/

Task 1: Special Positions
Submitted by: Mohammad Sajid Anwar
You are given a m x n binary matrix.

Write a script to return the number of special positions in the given binary matrix.

A position (i, j) is called special if $matrix[i][j] == 1 and all other elements in the row i and column j are 0.

Example 1
Input: $matrix = [ [1, 0, 0],
                   [0, 0, 1],
                   [1, 0, 0],
                 ]
Output: 1

There is only one special position (1, 2) as $matrix[1][2] == 1
and all other elements in row 1 and column 2 are 0.
Example 2
Input: $matrix = [ [1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1],
                 ]
Output: 3

Special positions are (0,0), (1, 1) and (2,2).

Task 2: Equalize Array
Submitted by: Mohammad Sajid Anwar
You are give an array of integers, @ints and two integers, $x and $y.

Write a script to execute one of the two options:

Level 1:
Pick an index i of the given array and do $ints[i] += 1

Level 2:
Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.
You are allowed to perform as many levels as you want to make every elements in the given array equal. There is cost attach for each level, for Level 1, the cost is $x and $y for Level 2.

In the end return the minimum cost to get the work done.

Example 1
Input: @ints = (4, 1), $x = 3 and $y = 2
Output: 9

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 2)

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 3)

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 4)

We perforned operation Level 1, 3 times.
So the total cost would be 3 x $x => 3 x 3 => 9
Example 2
Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
Output: 6

Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
@ints = (3, 4, 3, 3, 5)

Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
@ints = (4, 4, 4, 3, 5)

Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
@ints = (5, 4, 4, 4, 5)

Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
@ints = (5, 5, 5, 4, 5)

Level 1: i=3, so $ints[3] += 1
@ints = (5, 5, 5, 5, 5)

We perforned operation Level 1, 1 time and Level 2, 4 times.
So the total cost would be (1 x $x) + (4 x $y) => (1 x 2) + (4 x 1) => 6
