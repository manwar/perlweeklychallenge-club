Perl Weekly Challenge 215
https://theweeklychallenge.org/blog/perl-weekly-challenge-215/

Task 1: Odd one Out
Submitted by: Mohammad S Anwar
You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the number of words in the list that are not alphabetically sorted.


Example 1
Input: @words = ('abc', 'xyz', 'tsu')
Output: 1

The words 'abc' and 'xyz' are sorted and can't be removed.
The word 'tsu' is not sorted and hence can be removed.

Example 2
Input: @words = ('rat', 'cab', 'dad')
Output: 3

None of the words in the given list are sorted.
Therefore all three needs to be removed.

Example 3
Input: @words = ('x', 'y', 'z')
Output: 0


Task 2: Number Placement
Submitted by: Mohammad S Anwar
You are given a list of numbers having just 0 and 1. You are also given placement count (>=1).

Write a script to find out if it is possible to replace 0 with 1 in the given list. The only condition is that you can only replace when there is no 1 on either side. Print 1 if it is possible otherwise 0.

Example 1:
Input: @numbers = (1,0,0,0,1), $count = 1
Output: 1

You are asked to replace only one 0 as given count is 1.
We can easily replace middle 0 in the list i.e. (1,0,1,0,1).

Example 2:
Input: @numbers = (1,0,0,0,1), $count = 2
Output: 0

You are asked to replace two 0's as given count is 2.
It is impossible to replace two 0's.

Example 3:
Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
Output: 1
