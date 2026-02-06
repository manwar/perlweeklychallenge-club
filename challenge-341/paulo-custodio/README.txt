Challenge 341
https://theweeklychallenge.org/blog/perl-weekly-challenge-341/

Task 1: Broken Keyboard
Submitted by: Mohammad Sajid Anwar
You are given a string containing English letters only and also you are given broken keys.

Write a script to return the total words in the given sentence can be typed completely.


Example 1
Input: $str = 'Hello World', @keys = ('d')
Output: 1

With broken key 'd', we can only type the word 'Hello'.

Example 2
Input: $str = 'apple banana cherry', @keys = ('a', 'e')
Output: 0

Example 3
Input: $str = 'Coding is fun', @keys = ()
Output: 3

No keys broken.

Example 4
Input: $str = 'The Weekly Challenge', @keys = ('a','b')
Output: 2

Example 5
Input: $str = 'Perl and Python', @keys = ('p')
Output: 1

Task 2: Reverse Prefix
Submitted by: Mohammad Sajid Anwar
You are given a string, $str and a character in the given string, $char.

Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.


Example 1
Input: $str = "programming", $char = "g"
Output: "gorpramming"

Reverse of prefix "prog" is "gorp".

Example 2
Input: $str = "hello", $char = "h"
Output: "hello"

Example 3
Input: $str = "abcdefghij", $char = "h"
Output: "hgfedcbaij"

Example 4
Input: $str = "reverse", $char = "s"
Output: "srevere"

Example 5
Input: $str = "perl", $char = "r"
Output: "repl"
