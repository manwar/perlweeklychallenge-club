Challenge 313
https://theweeklychallenge.org/blog/perl-weekly-challenge-313/

Task 1: Broken Keys
Submitted by: Mohammad Sajid Anwar
You have a broken keyboard which sometimes type a character more than once.

You are given a string and actual typed string.

Write a script to find out if the actual typed string is meant for the given string.

Example 1
Input: $name = "perl", $typed = "perrrl"
Output: true

Here "r" is pressed 3 times instead of 1 time.
Example 2
Input: $name = "raku", $typed = "rrakuuuu"
Output: true
Example 3
Input: $name = "python", $typed = "perl"
Output: false
Example 4
Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true

Task 2: Reverse Letters
Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to reverse only the alphabetic characters in the string.

Example 1
Input: $str = "p-er?l"
Output: "l-re?p"
Example 2
Input: $str = "wee-k!L-y"
Output: "yLk-e!e-w"
Example 3
Input: $str = "_c-!h_all-en!g_e"
Output: "_e-!g_nel-la!h_c"
