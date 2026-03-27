Perl Weekly Challenge 366
https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

Task 1: Count Prefixes
Submitted by: Mohammad Sajid Anwar
You are given an array of words and a string (contains only lowercase English letters).

Write a script to return the number of words in the given array that are a prefix of the given string.

Example 1
Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
Output: 4

Example 2
Input: @array = ("cat", "dog", "fish"), $str = "bird"
Output: 0

Example 3
Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
Output: 4

Example 4
Input: @array = ("", "code", "coding", "cod"), $str = "coding"
Output: 3

Example 5
Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
Output: 7

Task 2: Valid Times
Submitted by: Mohammad Sajid Anwar
You are given a time in the form ‘HH:MM’. The earliest possible time is ‘00:00’ and the latest possible time is ‘23:59’. In the string time, the digits represented by the ‘?’ symbol are unknown, and must be replaced with a digit from 0 to 9.

Write a script to return the count different ways we can make it a valid time.

Example 1
Input: $time = "?2:34"
Output: 3

0 -> "02:34" valid
1 -> "12:34" valid
2 -> "22:34" valid

Example 2
Input: $time = "?4:?0"
Output: 12

Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)

Total: 2 × 6 = 12

Example 3
Input: $time = "??:??"
Output: 1440

Hours: from 00 to 23 -> 24 possibilities
Minutes: from 00 to 59 -> 60 possibilities

Total: 24 × 60 = 1440

Example 4
Input: $time = "?3:45"
Output: 3

If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23 is valid

Therefore: 0,1,2 are all valid -> 3 possibilities

Example 5
Input: $time = "2?:15"
Output: 4

Tens digit is 2, so hours can be 20-23
Ones digit can be 0,1,2,3 (4 possibilities)

Therefore: 4 valid times
