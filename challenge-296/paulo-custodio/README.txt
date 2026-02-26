Challenge 296
https://theweeklychallenge.org/blog/perl-weekly-challenge-296/

Task 1: String Compression
Submitted by: Mohammad Sajid Anwar
You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the examples.

A compressed unit can be either a single character or a count followed by a character.

BONUS: Write a decompression function.

Example 1
Input: $chars = "abbc"
Output: "a2bc"
Example 2
Input: $chars = "aaabccc"
Output: "3ab3c"
Example 3
Input: $chars = "abcc"
Output: "ab2c"

Task 2: Matchstick Square
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find if it is possible to make one square using the sticks as in the given array @ints where $ints[ì] is the length of ith stick.

Example 1
Input: @ints = (1, 2, 2, 2, 1)
Output: true

Top: $ints[1] = 2
Bottom: $ints[2] = 2
Left: $ints[3] = 2
Right: $ints[0] and $ints[4] = 2
Example 2
Input: @ints = (2, 2, 2, 4)
Output: false
Example 3
Input: @ints = (2, 2, 2, 2, 4)
Output: false
Example 4
Input: @ints = (3, 4, 1, 4, 3, 1)
Output: true
