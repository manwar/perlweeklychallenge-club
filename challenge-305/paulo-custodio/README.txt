Challenge 305
https://theweeklychallenge.org/blog/perl-weekly-challenge-305/

Task 1: Binary Prefix
Submitted by: Mohammad Sajid Anwar
You are given a binary array.

Write a script to return an array of booleans where the partial binary number up to that point is prime.

Example 1
Input: @binary = (1, 0, 1)
Output: (false, true, true)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime
Example 2
Input: @binary = (1, 1, 0)
Output: (false, true, false)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime
Example 3
Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
Output: (false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)

Task 2: Alien Dictionary
Submitted by: Mohammad Sajid Anwar
You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the alien dictionary characters.

Example 1
Input: @words = ("perl", "python", "raku")
       @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")
Example 2
Input: @words = ("the", "weekly", "challenge")
       @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")
