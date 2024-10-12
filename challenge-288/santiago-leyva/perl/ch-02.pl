=begin
You are given a string, $str, which is an integer.

Write a script to find out the closest palindrome, not including itself. If there are more than one then return the smallest.

The closest is defined as the absolute difference minimized between two integers.

Example 1
Input: $str = "123"
Output: "121"
Example 2
Input: $str = "2"
Output: "1"

There are two closest palindrome "1" and "3". Therefore we return the smallest "1".
Example 3
Input: $str = "1400"
Output: "1441"
Example 4
Input: $str = "1001"
Output: "999"
=cut

