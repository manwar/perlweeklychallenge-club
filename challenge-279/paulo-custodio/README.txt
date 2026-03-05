Challenge 279
https://theweeklychallenge.org/blog/perl-weekly-challenge-279/

Task 1: Sort Letters
Submitted by: Mohammad Sajid Anwar
You are given two arrays, @letters and @weights.

Write a script to sort the given array @letters based on the @weights.

Example 1
Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL
Example 2
Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU
Example 3
Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON

Task 2: Split String
Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to split the given string into two containing exactly same number of vowels and return true if you can otherwise false.

Example 1
Input: $str = "perl"
Ouput: false
Example 2
Input: $str = "book"
Ouput: true

Two possible strings "bo" and "ok" containing exactly one vowel each.
Example 3
Input: $str = "good morning"
Ouput: true

Two possible strings "good " and "morning" containing two vowels each or "good m" and "orning" containing two vowels each.
