Challenge 342
https://theweeklychallenge.org/blog/perl-weekly-challenge-342/

Task 1: Balance String
Submitted by: Mohammad Sajid Anwar
You are given a string made up of lowercase English letters and digits only.

Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.


Example 1
Input: $str = "a0b1c2"
Output: "0a1b2c"

Example 2
Input: $str = "abc12"
Output: "a1b2c"

Example 3
Input: $str = "0a2b1c3"
Output: "0a1b2c3"

Example 4
Input: $str = "1a23"
Output: ""

Example 5
Input: $str = "ab123"
Output: "1a2b3"

Task 2: Max Score
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, containing 0 and 1 only.

Write a script to return the max score after splitting the string into two non-empty substrings. The score after splitting a string is the number of zeros in the left substring plus the number of ones in the right substring.


Example 1
Input: $str = "0011"
Output: 4

1: left = "0", right = "011" => 1 + 2 => 3
2: left = "00", right = "11" => 2 + 2 => 4
3: left = "001", right = "1" => 2 + 1 => 3

Example 2
Input: $str = "0000"
Output: 3

1: left = "0", right = "000" => 1 + 0 => 1
2: left = "00", right = "00" => 2 + 0 => 2
3: left = "000", right = "0" => 3 + 0 => 3

Example 3
Input: $str = "1111"
Output: 3

1: left = "1", right = "111" => 0 + 3 => 3
2: left = "11", right = "11" => 0 + 2 => 2
3: left = "111", right = "1" => 0 + 1 => 1

Example 4
Input: $str = "0101"
Output: 3

1: left = "0", right = "101" => 1 + 2 => 3
2: left = "01", right = "01" => 1 + 1 => 2
3: left = "010", right = "1" => 2 + 1 => 3

Example 5
Input: $str = "011101"
Output: 5

1: left = "0", right = "11101" => 1 + 4 => 5
2: left = "01", right = "1101" => 1 + 3 => 4
3: left = "011", right = "101" => 1 + 2 => 3
4: left = "0111", right = "01" => 1 + 1 => 2
5: left = "01110", right = "1" => 2 + 1 => 3
