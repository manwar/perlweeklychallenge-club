Perl Weekly Challenge 245
https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

Task 1: Sort Language
Submitted by: Mohammad S Anwar
You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

Example 1
Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')

Example 2
Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')


Task 2: Largest of Three
Submitted by: Mohammad S Anwar
You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the given integers in any order which is also multiple of 3. Return -1 if none found.


Example 1
Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0

Example 2
Input: @ints = (8, 6, 7, 1, 0)
Output: 8760

Example 3
Input: @ints = (1)
Output: -1
