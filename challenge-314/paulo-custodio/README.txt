Challenge 314
https://theweeklychallenge.org/blog/perl-weekly-challenge-314/

Task 1: Equal Strings
Submitted by: Mohammad Sajid Anwar
You are given three strings.

You are allowed to remove the rightmost character of a string to make all equals.

Write a script to return the number of operations to make it equal otherwise -1.

Example 1
Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
Output: 2

Operation 1: Delete "c" from the string "abc"
Operation 2: Delete "b" from the string "abb"
Example 2
Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
Output: -1
Example 3
Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
Output: 3

Task 2: Sort Column
Submitted by: Mohammad Sajid Anwar
You are given a list of strings of same length.

Write a script to make each column sorted lexicographically by deleting any non sorted columns.

Return the total columns deleted.

Example 1
Input: @list = ("swpc", "tyad", "azbe")
Output: 2

swpc
tyad
azbe

Column 1: "s", "t", "a" => non sorted
Column 2: "w", "y", "z" => sorted
Column 3: "p", "a", "b" => non sorted
Column 4: "c", "d", "e" => sorted

Total columns to delete to make it sorted lexicographically.
Example 2
Input: @list = ("cba", "daf", "ghi")
Output: 1
Example 3
Input: @list = ("a", "b", "c")
Output: 0
