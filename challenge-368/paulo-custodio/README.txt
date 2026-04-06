Perl Weekly Challenge 368
https://theweeklychallenge.org/blog/perl-weekly-challenge-368/

Task 1: Make it Bigger
Submitted by: Mohammad Sajid Anwar
You are given a given a string number and a character digit.

Write a script to remove exactly one occurrence of the given character digit from the given string number, resulting the decimal form is maximised.

Example 1
Input: $str = "15456", $char = "5"
Output: "1546"

Removing the second "5" is better because the digit following it (6) is
greater than 5. In the first case, 5 was followed by 4 (a decrease),
which makes the resulting number smaller.

Example 2
Input: $str = "7332", $char = "3"
Output: "732"

Example 3
Input: $str = "2231", $char = "2"
Output: "231"

Removing either "2" results in the same string here. By removing a "2",
we allow the "3" to move up into a higher decimal place.

Example 4
Input: $str = "543251", $char = "5"
Output: "54321"

If we remove the first "5", the number starts with 4. If we remove the
second "5", the number still starts with 5. Keeping the largest possible
digit in the highest place value is almost always the priority.

Example 5
Input: $str = "1921", $char = "1"
Output: "921"

Task 2: Big and Little Omega
Submitted by: Roger Bell_West
You are given a positive integer $number and a mode flag $mode. If the mode flag is zero, calculate little omega (the count of all distinct prime factors of that number). If it is one, calculate big omega (the count of all prime factors including duplicates).

Example 1
Input: $number = 100061
       $mode = 0
Output: 3

Prime factors are 13, 43, 179. Count is 3.

Example 2
Input: $number = 971088
       $mode = 0
Output: 3

Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

Example 3
Input: $number = 63640
       $mode = 1
Output: 6

Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

Example 4
Input: $number = 988841
       $mode = 1
Output: 2

Example 5
Input: $number = 211529
       $mode = 0
Output: 2
