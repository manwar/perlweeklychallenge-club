Challenge 319
https://theweeklychallenge.org/blog/perl-weekly-challenge-319/

Task 1: Word Count
Submitted by: Mohammad Sajid Anwar
You are given a list of words containing alphabetic characters only.

Write a script to return the count of words either starting with a vowel or ending with a vowel.


Example 1
Input: @list = ("unicode", "xml", "raku", "perl")
Output: 2

The words are "unicode" and "raku".

Example 2
Input: @list = ("the", "weekly", "challenge")
Output: 2

Example 3
Input: @list = ("perl", "python", "postgres")
Output: 0

Task 2: Minimum Common
Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers.

Write a script to return the minimum integer common to both arrays. If none found return -1.


Example 1
Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (3, 4, 5, 6)
Output: 3

The common integer in both arrays: 3, 4
The minimum is 3.

Example 2
Input: @array_1 = (1, 2, 3)
       @array_2 = (2, 4)
Output: 2

Example 3
Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (5, 6, 7, 8)
Output: -1
