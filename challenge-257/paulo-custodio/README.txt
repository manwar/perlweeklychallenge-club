Challenge 257
https://theweeklychallenge.org/blog/perl-weekly-challenge-257/

Task 1: Smaller than Current
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find out how many integers are smaller than current i.e. foreach ints[i], count ints[j] < ints[i] where i != j.

Example 1
Input: @ints = (5, 2, 1, 6)
Output: (2, 1, 0, 3)

For $ints[0] = 5, there are two integers (2,1) smaller than 5.
For $ints[1] = 2, there is one integer (1) smaller than 2.
For $ints[2] = 1, there is none integer smaller than 1.
For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.

Example 2
Input: @ints = (1, 2, 0, 3)
Output: (1, 2, 0, 3)

Example 3
Input: @ints = (0, 1)
Output: (0, 1)

Example 4
Input: @ints = (9, 4, 9, 2)
Output: (2, 1, 2, 0)


Task 2: Reduced Row Echelon
Submitted by: Ali Moradi
Given a matrix M, check whether the matrix is in reduced row echelon form.

A matrix must have the following properties to be in reduced row echelon form:

1. If a row does not consist entirely of zeros, then the first
   nonzero number in the row is a 1. We call this the leading 1.
2. If there are any rows that consist entirely of zeros, then
   they are grouped together at the bottom of the matrix.
3. In any two successive rows that do not consist entirely of zeros,
   the leading 1 in the lower row occurs farther to the right than
   the leading 1 in the higher row.
4. Each column that contains a leading 1 has zeros everywhere else
   in that column.

For example:

[
   [1,0,0,1],
   [0,1,0,2],
   [0,0,1,3]
]

The above matrix is in reduced row echelon form since the first nonzero number in each row is a 1, leading 1s in each successive row are farther to the right, and above and below each leading 1 there are only zeros.

For more information check out this wikipedia article.

Example 1
    Input: $M = [
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 2
    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ]
    Output: 1

Example 3
    Input: $M = [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 1

Example 4
    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
                ]
    Output: 0

Example 5
    Input: $M = [
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 6
    Input: $M = [
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 0
