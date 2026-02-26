Challenge 295
https://theweeklychallenge.org/blog/perl-weekly-challenge-295/

Task 1: Word Break
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, and list of words, @words.

Write a script to return true or false whether the given string can be segmented into a space separated sequence of one or more words from the given list.

Example 1
Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
Output: true
Example 2
Input: $str = "perlrakuperl", @words = ("raku", "perl")
Output: true
Example 3
Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
Output: false

Task 2: Jump Game
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the minimum number of jumps to reach the last element. $ints[$i] represents the maximum length of a forward jump from the index $i. In case last element is unreachable then return -1.

Example 1
Input: @ints = (2, 3, 1, 1, 4)
Output: 2

Jump 1 step from index 0 then 3 steps from index 1 to the last element.
Example 2
Input: @ints = (2, 3, 0, 4)
Output: 2
Example 3
Input: @ints = (2, 0, 0, 4)
Output: -1
