Challenge 311
https://theweeklychallenge.org/blog/perl-weekly-challenge-311/

Task 1: Upper Lower
Submitted by: Mohammad Sajid Anwar
You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower in the given string.

Example 1
Input: $str = "pERl"
Output: "PerL"
Example 2
Input: $str = "rakU"
Output: "RAKu"
Example 3
Input: $str = "PyThOn"
Output: "pYtHoN"

Task 2: Group Digit Sum
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, made up of digits, and an integer, $int, which is less than the length of the given string.

Write a script to divide the given string into consecutive groups of size $int (plus one for leftovers if any). Then sum the digits of each group, and concatenate all group sums to create a new string. If the length of the new string is less than or equal to the given integer then return the new string, otherwise continue the process.

Example 1
Input: $str = "111122333", $int = 3
Output: "359"

Step 1: "111", "122", "333" => "359"
Example 2
Input: $str = "1222312", $int = 2
Output: "76"

Step 1: "12", "22", "31", "2" => "3442"
Step 2: "34", "42" => "76"
Example 3
Input: $str = "100012121001", $int = 4
Output: "162"

Step 1: "1000", "1212", "1001" => "162"
