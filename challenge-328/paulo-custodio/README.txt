Challenge 328
https://theweeklychallenge.org/blog/perl-weekly-challenge-328/

Task 1: Replace all ?
Submitted by: Mohammad Sajid Anwar
You are given a string containing only lower case English letters and ?.

Write a script to replace all ? in the given string so that the string doesn’t contain consecutive repeating characters.


Example 1
Input: $str = "a?z"
Output: "abz"

There can be many strings, one of them is "abz".
The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'.

Example 2
Input: $str = "pe?k"
Output: "peak"

Example 3
Input: $str = "gra?te"
Output: "grabte"

Task 2: Good String
Submitted by: Mohammad Sajid Anwar
You are given a string made up of lower and upper case English letters only.

Write a script to return the good string of the given string. A string is called good string if it doesn’t have two adjacent same characters, one in upper case and other is lower case.

UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are same characters, one in lower case and other in upper case, order is not important.


Example 1
Input: $str = "WeEeekly"
Output: "Weekly"

We can remove either, "eE" or "Ee" to make it good.

Example 2
Input: $str = "abBAdD"
Output: ""

We remove "bB" first: "aAdD"
Then we remove "aA": "dD"
Finally remove "dD".

Example 3
Input: $str = "abc"
Output: "abc"
