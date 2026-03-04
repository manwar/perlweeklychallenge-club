Challenge 288
https://theweeklychallenge.org/blog/perl-weekly-challenge-288/

Task 1: Closest Palindrome
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, which is an integer.

Write a script to find out the closest palindrome, not including itself. If there are more than one then return the smallest.

The closest is defined as the absolute difference minimized between two integers.

Example 1
Input: $str = "123"
Output: "121"
Example 2
Input: $str = "2"
Output: "1"

There are two closest palindrome "1" and "3". Therefore we return the smallest "1".
Example 3
Input: $str = "1400"
Output: "1441"
Example 4
Input: $str = "1001"
Output: "999"

Task 2: Contiguous Block
Submitted by: Peter Campbell Smith
You are given a rectangular matrix where all the cells contain either x or o.

Write a script to determine the size of the largest contiguous block.

A contiguous block consists of elements containing the same symbol which share an edge (not just a corner) with other elements in the block, and where there is a path between any two of these elements that crosses only those shared edges.

Example 1
    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'o', 'o'],
                     ]
    Ouput: 11

        There is a block of 9 contiguous cells containing 'x'.
        There is a block of 11 contiguous cells containing 'o'.
Example 2
    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'x'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                     ]
    Ouput: 11

        There is a block of 11 contiguous cells containing 'x'.
        There is a block of 9 contiguous cells containing 'o'.
Example 3
    Input: $matrix = [
                       ['x', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                       ['o', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                     ]
    Ouput: 7

        There is a block of 7 contiguous cells containing 'o'.
        There are two other 2-cell blocks of 'o'.
        There are three 2-cell blocks of 'x' and one 3-cell.
