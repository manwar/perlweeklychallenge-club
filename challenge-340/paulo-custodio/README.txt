Challenge 340
https://theweeklychallenge.org/blog/perl-weekly-challenge-340/

Task 1: Duplicate Removals
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have been made. Repeat duplicate removals on the given string until we no longer can.

A duplicate removal consists of choosing two adjacent and equal letters and removing them.


Example 1
Input: $str = 'abbaca'
Output: 'ca'

Step 1: Remove 'bb' => 'aaca'
Step 2: Remove 'aa' => 'ca'

Example 2
Input: $str = 'azxxzy'
Output: 'ay'

Step 1: Remove 'xx' => 'azzy'
Step 2: Remove 'zz' => 'ay'

Example 3
Input: $str = 'aaaaaaaa'
Output: ''

Step 1: Remove 'aa' => 'aaaaaa'
Step 2: Remove 'aa' => 'aaaa'
Step 3: Remove 'aa' => 'aa'
Step 4: Remove 'aa' => ''

Example 4
Input: $str = 'aabccba'
Output: 'a'

Step 1: Remove 'aa' => 'bccba'
Step 2: Remove 'cc' => 'bba'
Step 3: Remove 'bb' => 'a'

Example 5
Input: $str = 'abcddcba'
Output: ''

Step 1: Remove 'dd' => 'abccba'
Step 2: Remove 'cc' => 'abba'
Step 3: Remove 'bb' => 'aa'
Step 4: Remove 'aa' => ''

Task 2: Ascending Numbers
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, is a list of tokens separated by a single space. Every token is either a positive number consisting of digits 0-9 with no leading zeros, or a word consisting of lowercase English letters.

Write a script to check if all the numbers in the given string are strictly increasing from left to right.


Example 1
Input: $str = "The cat has 3 kittens 7 toys 10 beds"
Output: true

Numbers 3, 7, 10 - strictly increasing.

Example 2
Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
Output: false

Example 3
Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
Output: true

Example 4
Input: $str = 'Bob has 10 cars 10 bikes'
Output: false

Example 5
Input: $str = 'Zero is 0 one is 1 two is 2'
Output: true
