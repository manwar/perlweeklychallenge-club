Challenge 253
https://theweeklychallenge.org/blog/perl-weekly-challenge-253/

Task 1: Split Strings
Submitted by: Mohammad S Anwar
You are given an array of strings and a character separator.

Write a script to return all words separated by the given character excluding empty string.

Example 1
Input: @words = ("one.two.three","four.five","six")
       $separator = "."
Output: "one","two","three","four","five","six"

Example 2
Input: @words = ("$perl$$", "$$raku$")
       $separator = "$"
Output: "perl","raku"


Task 2: Weakest Row
Submitted by: Mohammad S Anwar
You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear before 0.

A row i is weaker than a row j if one of the following is true:

a) The number of 1s in row i is less than the number of 1s in row j.
b) Both rows have the same number of 1 and i < j.

Write a script to return the order of rows from weakest to strongest.

Example 1
Input: $matrix = [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ]
Output: (2, 0, 3, 1, 4)

The number of 1s in each row is:
- Row 0: 2
- Row 1: 4
- Row 2: 1
- Row 3: 2
- Row 4: 5

Example 2
Input: $matrix = [
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ]
Output: (0, 2, 3, 1)

The number of 1s in each row is:
- Row 0: 1
- Row 1: 4
- Row 2: 1
- Row 3: 1
