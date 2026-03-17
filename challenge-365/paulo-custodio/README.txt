Perl Weekly Challenge 365
https://theweeklychallenge.org/blog/perl-weekly-challenge-365/

Task 1: Alphabet Index Digit Sum
Submitted by: Mohammad Sajid Anwar
You are given a string $str consisting of lowercase English letters, and an integer $k.

Write a script to convert a lowercase string into numbers using alphabet positions (a=1 … z=26), concatenate them to form an integer, then compute the sum of its digits repeatedly $k times, returning the final value.

Example 1
Input: $str = "abc", $k = 1
Output: 6

Conversion: a = 1, b = 2, c = 3 -> 123
Digit sum: 1 + 2 + 3 = 6

Example 2
Input: $str = "az", $k = 2
Output: 9

Conversion: a = 1, z = 26 -> 126
1st sum: 1 + 2 + 6 = 9
2nd sum: 9

Example 3
Input: $str = "cat", $k = 1
Output: 6

Conversion: c = 3, a = 1, t = 20 -> 3120
Digit sum: 3 + 1 + 2 + 0 = 6

Example 4
Input: $str = "dog", $k = 2
Output: 8

Conversion: d = 4, o = 15, g = 7 -> 4157
1st sum: 4 + 1 + 5 + 7 = 17
2nd sum: 1 + 7 = 8

Example 5
Input: $str = "perl", $k = 3
Output: 6

Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
2nd sum: 2+4 = 6
3rd sum: 6

Task 2: Valid Token Counter
Submitted by: Mohammad Sajid Anwar
You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count how many are valid words. A token is valid if it contains no digits, has at most one hyphen surrounded by lowercase letters, and at most one punctuation mark (!, ., ,) appearing only at the end.

Example 1
Input: $str = "cat and dog"
Output: 3

Tokens: "cat", "and", "dog"

Example 2
Input: $str = "a-b c! d,e"
Output: 2

Tokens: "a-b", "c!", "d,e"
"a-b" -> valid (one hyphen between letters)
"c!"  -> valid (punctuation at end)
"d,e" -> invalid (punctuation not at end)

Example 3
Input: $str = "hello-world! this is fun"
Output: 4

Tokens: "hello-world!", "this", "is", "fun"
All satisfy the rules.

Example 4
Input: $str = "ab- cd-ef gh- ij!"
Output: 2

Tokens: "ab-", "cd-ef", "gh-", "ij!"
"ab-"   -> invalid (hyphen not surrounded by letters)
"cd-ef" -> valid
"gh-"   -> invalid
"ij!"   -> valid

Example 5
Input: $str = "wow! a-b-c nice."
Output: 2

Tokens: "wow!", "a-b-c", "nice."
"wow!"  -> valid
"a-b-c" -> invalid (more than one hyphen)
"nice." -> valid
