Challenge 330
https://theweeklychallenge.org/blog/perl-weekly-challenge-330/

Task 1: Clear Digits
Submitted by: Mohammad Sajid Anwar
You are given a string containing only lower case English letters and digits.

Write a script to remove all digits by removing the first digit and the closest non-digit character to its left.


Example 1
Input: $str = "cab12"
Output: "c"

Round 1: remove "1" then "b" => "ca2"
Round 2: remove "2" then "a" => "c"

Example 2
Input: $str = "xy99"
Output: ""

Round 1: remove "9" then "y" => "x9"
Round 2: remove "9" then "x" => ""

Example 3
Input: $str = "pa1erl"
Output: "perl"

Task 2: Title Capital
Submitted by: Mohammad Sajid Anwar
You are given a string made up of one or more words separated by a single space.

Write a script to capitalise the given title. If the word length is 1 or 2 then convert the word to lowercase otherwise make the first character uppercase and remaining lowercase.


Example 1
Input: $str = "PERL IS gREAT"
Output: "Perl is Great"

Example 2
Input: $str = "THE weekly challenge"
Output: "The Weekly Challenge"

Example 3
Input: $str = "YoU ARE A stAR"
Output: "You Are a Star"
