Perl Weekly Challenge 282
https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

Task 1: Good Integer
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int, having 3 or more digits.

Write a script to return the Good Integer in the given integer or -1 if none found.

A good integer is exactly three consecutive matching digits.

Example 1
Input: $int = 12344456
Output: "444"
Example 2
Input: $int = 1233334
Output: -1
Example 3
Input: $int = 10020003
Output: "000"

Task 2: Changing Keys
Submitted by: Mohammad Sajid Anwar
You are given an alphabetic string, $str, as typed by user.

Write a script to find the number of times user had to change the key to type the given string. Changing key is defined as using a key different from the last used key. The shift and caps lock keys won’t be counted.

Example 1
Input: $str = 'pPeERrLl'
Ouput: 3

p -> P : 0 key change
P -> e : 1 key change
e -> E : 0 key change
E -> R : 1 key change
R -> r : 0 key change
r -> L : 1 key change
L -> l : 0 key change
Example 2
Input: $str = 'rRr'
Ouput: 0
Example 3
Input: $str = 'GoO'
Ouput: 1
