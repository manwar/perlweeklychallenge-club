Challenge 358
https://theweeklychallenge.org/blog/perl-weekly-challenge-358/

Task 1: Max Str Value
Submitted by: Mohammad Sajid Anwar
You are given an array of alphanumeric string, @strings.

Write a script to find the max value of alphanumeric string in the given array. The numeric representation of the string, if it comprises of digits only otherwise length of the string.

Example 1
Input: @strings = ("123", "45", "6")
Output: 123

"123" -> 123
"45"  -> 45
"6"   -> 6

Example 2
Input: @strings = ("abc", "de", "fghi")
Output: 4

"abc"  -> 3
"de"   -> 2
"fghi" -> 4

Example 3
Input: @strings = ("0012", "99", "a1b2c")
Output: 99

"0012"  -> 12
"99"    -> 99
"a1b2c" -> 5

Example 4
Input: @strings = ("x", "10", "xyz", "007")
Output: 10

"x"   -> 1
"xyz" -> 3
"007" -> 7
"10"  -> 10

Example 5
Input: @strings = ("hello123", "2026", "perl")
Output: 2026

"hello123" -> 8
"perl"     -> 4
"2026"     -> 2026

Task 2: Encrypted String
Submitted by: Mohammad Sajid Anwar
You are given a string $str and an integer $int.

Write a script to encrypt the string using the algorithm - for each character $char in $str, replace $char with the $int th character after $char in the alphabet, wrapping if needed and return the encrypted string.

Example 1
Input: $str = "abc", $int = 1
Output: "bcd"

Example 2
Input: $str = "xyz", $int = 2
Output: "zab"

Example 3
Input: $str = "abc", $int = 27
Output: "bcd"

Example 4
Input: $str = "hello", $int = 5
Output: "mjqqt"

Example 5
Input: $str = "perl", $int = 26
Output: "perl"
