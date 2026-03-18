Perl Weekly Challenge 291
https://theweeklychallenge.org/blog/perl-weekly-challenge-291/

Task 1: Middle Index
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst all the possible ones.

A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] == ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].

If MI == 0, the left side sum is considered to be 0. Similarly,
if MI == ints.length - 1, the right side sum is considered to be 0.
Return the leftmost MI that satisfies the condition, or -1 if there is no such index.

Example 1
Input: @ints = (2, 3, -1, 8, 4)
Output: 3

The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
The sum of the numbers after index 3 is: 4 = 4
Example 2
Input: @ints = (1, -1, 4)
Output: 2

The sum of the numbers before index 2 is: 1 + -1 = 0
The sum of the numbers after index 2 is: 0
Example 3
Input: @ints = (2, 5)
Output: -1

There is no valid MI.

Task 2: Poker Hand Rankings
Submitted by: Robbie Hatley
A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no wild cards. An ace can rank either high or low.

Write a script to determine the following three things:

1. How many different 5-card hands can be dealt?
2. How many different hands of each of the 10 ranks can be dealt?
   See here for descriptions of the 10 ranks of Poker hands:
   https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
3. Check the ten numbers you get in step 2 by adding them together
   and showing that they're equal to the number you get in step 1.
