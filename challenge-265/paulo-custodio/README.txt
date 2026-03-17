Perl Weekly Challenge 265
https://theweeklychallenge.org/blog/perl-weekly-challenge-265/

Task 1: 33% Appearance
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find an integer in the given array that appeared 33% or more. If more than one found, return the smallest. If none found then return undef.

Example 1
Input: @ints = (1,2,3,3,3,3,4,2)
Output: 3

1 appeared 1 times.
2 appeared 2 times.
3 appeared 4 times.

3 appeared 50% (>33%) in the given array.
Example 2
Input: @ints = (1,1)
Output: 1

1 appeared 2 times.

1 appeared 100% (>33%) in the given array.
Example 3
Input: @ints = (1,2,3)
Output: 1

1 appeared 1 times.
2 appeared 1 times.
3 appeared 1 times.

Since all three appeared 33.3% (>33%) in the given array.
We pick the smallest of all.

Task 2: Completing Word
Submitted by: Mohammad Sajid Anwar
You are given a string, $str containing alphnumeric characters and array of strings (alphabetic characters only), @str.

Write a script to find the shortest completing word. If none found return empty string.

A completing word is a word that contains all the letters in the given string, ignoring space and number. If a letter appeared more than once in the given string then it must appear the same number or more in the word.

Example 1
Input: $str = 'aBc 11c'
       @str = ('accbbb', 'abc', 'abbc')
Output: 'accbbb'

The given string contains following, ignoring case and number:
a 1 times
b 1 times
c 2 times

The only string in the given array that satisfies the condition is 'accbbb'.
Example 2
Input: $str = 'Da2 abc'
       @str = ('abcm', 'baacd', 'abaadc')
Output: 'baacd'

The given string contains following, ignoring case and number:
a 2 times
b 1 times
c 1 times
d 1 times

The are 2 strings in the given array that satisfies the condition:
'baacd' and 'abaadc'.

Shortest of the two is 'baacd'
Example 3
Input: $str = 'JB 007'
       @str = ('jj', 'bb', 'bjb')
Output: 'bjb'

The given string contains following, ignoring case and number:
j 1 times
b 1 times

The only string in the given array that satisfies the condition is 'bjb'.
