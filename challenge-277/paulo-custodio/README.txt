Challenge 277
https://theweeklychallenge.org/blog/perl-weekly-challenge-277/

Task 1: Count Common
Submitted by: Mohammad Sajid Anwar
You are given two array of strings, @words1 and @words2.

Write a script to return the count of words that appears in both arrays exactly once.

Example 1
Input: @words1 = ("Perl", "is", "my", "friend")
       @words2 = ("Perl", "and", "Raku", "are", "friend")
Output: 2

The words "Perl" and "friend" appear once in each array.
Example 2
Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
       @words2 = ("Python", "is", "top", "in", "guest", "languages")
Output: 1
Example 3
Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
       @words2 = ("Crystal", "is", "similar", "to", "Ruby")
Output: 0

Task 2: Strong Pair
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to return the count of all strong pairs in the given array.

A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y).

Example 1
Input: @ints = (1, 2, 3, 4, 5)
Ouput: 4

Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)
Example 2
Input: @ints = (5, 7, 1, 7)
Ouput: 1

Strong Pairs: (5, 7)
