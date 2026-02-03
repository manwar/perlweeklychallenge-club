Challenge 355
https://theweeklychallenge.org/blog/perl-weekly-challenge-355/

Task 1: Thousand Separator
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.

Example 1
Input: $int = 123
Output: "123"

Example 2
Input: $int = 1234
Output: "1,234"

Example 3
Input: $int = 1000000
Output: "1,000,000"

Example 4
Input: $int = 1
Output: "1"

Example 5
Input: $int = 12345
Output: "12,345"

Task 2: Mountain Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to return true if the given array is a valid mountain array.

An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
Example 1
Input: @ints = (1, 2, 3, 4, 5)
Output: false

Example 2
Input: @ints = (0, 2, 4, 6, 4, 2, 0)
Output: true

Example 3
Input: @ints = (5, 4, 3, 2, 1)
Output: false

Example 4
Input: @ints = (1, 3, 5, 5, 4, 2)
Output: false

Example 5
Input: @ints = (1, 3, 2)
Output: true
