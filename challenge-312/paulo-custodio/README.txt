Challenge 312
https://theweeklychallenge.org/blog/perl-weekly-challenge-312/

Task 1: Minimum Time
Submitted by: Mohammad Sajid Anwar
You are given a typewriter with lowercase english letters a to z arranged in a circle.

Task 1

Typing a character takes 1 sec. You can move pointer one character clockwise or anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time it takes to print the given string.

Example 1
Input: $str = "abc"
Output: 5

The pointer is at 'a' initially.
1 sec - type the letter 'a'
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer clockwise to 'c'
1 sec - type the letter 'c'
Example 2
Input: $str = "bza"
Output: 7

The pointer is at 'a' initially.
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer anti-clockwise to 'a'
1 sec - move pointer anti-clockwise to 'z'
1 sec - type the letter 'z'
1 sec - move pointer clockwise to 'a'
1 sec - type the letter 'a'
Example 3
Input: $str = "zjpc"
Output: 34

Task 2: Balls and Boxes
Submitted by: Mohammad Sajid Anwar
There are $n balls of mixed colors: red, blue or green. They are all distributed in 10 boxes labelled 0-9.

You are given a string describing the location of balls.

Write a script to find the number of boxes containing all three colors. Return 0 if none found.

Example 1
Input: $str = "G0B1R2R0B0"
Output: 1

The given string describes there are 5 balls as below:
Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
Box 1: Blue(B1) => 1 ball
Box 2: Red(R2) => 1 ball
Example 2
Input: $str = "G1R3R6B3G6B1B6R1G3"
Output: 3

The given string describes there are 9 balls as below:
Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls
Example 3
Input: $str = "B3B2G1B3"
Output: 0

Box 1: Green(G1) => 1 ball
Box 2: Blue(B2)  => 1 ball
Box 3: Blue(B3)  => 2 balls
