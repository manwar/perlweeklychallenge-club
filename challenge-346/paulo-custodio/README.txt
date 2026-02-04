Challenge 346
https://theweeklychallenge.org/blog/perl-weekly-challenge-346/

Task 1: Longest Parenthesis
Submitted by: Mohammad Sajid Anwar
You are given a string containing only ( and ).

Write a script to find the length of the longest valid parenthesis.


Example 1
Input: $str = '(()())'
Output: 6

Valid Parenthesis: '(()())'

Example 2
Input: $str = ')()())'
Output: 4

Valid Parenthesis: '()()' at positions 1-4.

Example 3
Input: $str = '((()))()(((()'
Output: 8

Valid Parenthesis: '((()))()' at positions 0-7.

Example 4
Input: $str = '))))((()('
Output: 2

Valid Parenthesis: '()' at positions 6-7.

Example 5
Input: $str = '()(()'
Output: 2

Valid Parenthesis: '()' at positions 0-1 and 3-4.

Task 2: Magic Expression
Submitted by: Mohammad Sajid Anwar
You are given a string containing only digits and a target integer.

Write a script to insert binary operators +, - and * between the digits in the given string that evaluates to target integer.


Example 1
Input: $str = "123", $target = 6
Output: ("1*2*3", "1+2+3")

Example 2
Input: $str = "105", $target = 5
Output: ("1*0+5", "10-5")

Example 3
Input: $str = "232", $target = 8
Output: ("2*3+2", "2+3*2")

Example 4
Input: $str = "1234", $target = 10
Output: ("1*2*3+4", "1+2+3+4")

Example 5
Input: $str = "1001", $target = 2
Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
