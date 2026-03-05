Challenge 275
https://theweeklychallenge.org/blog/perl-weekly-challenge-275/

Task 1: Broken Keys
Submitted by: Mohammad Sajid Anwar
You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.

Example 1
Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
Output: 0
Example 2
Input: $sentence = "Perl and Raku", @keys = ('a')
Output: 1

Only Perl since the other word two words contain 'a' and can't be typed fully.
Example 3
Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
Output: 2
Example 4
Input: $sentence = "The joys of polyglottism", @keys = ('T')
Output: 2

Task 2: Replace Digits
Submitted by: Mohammad Sajid Anwar
You are given an alphanumeric string, $str, where each character is either a letter or a digit.

Write a script to replace each digit in the given string with the value of the previous letter plus (digit) places.

Example 1
Input: $str = 'a1c1e1'
Ouput: 'abcdef'

shift('a', 1) => 'b'
shift('c', 1) => 'd'
shift('e', 1) => 'f'
Example 2
Input: $str = 'a1b2c3d4'
Output: 'abbdcfdh'

shift('a', 1) => 'b'
shift('b', 2) => 'd'
shift('c', 3) => 'f'
shift('d', 4) => 'h'
Example 3
Input: $str = 'b2b'
Output: 'bdb'
Example 4
Input: $str = 'a16z'
Output: 'abgz'
