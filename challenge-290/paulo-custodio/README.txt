Perl Weekly Challenge 290
https://theweeklychallenge.org/blog/perl-weekly-challenge-290/

Task 1: Double Exist
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find if there exist two indices $i and $j such that:

1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]
Example 1
Input: @ints = (6, 2, 3, 3)
Output: true

For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
Example 2
Input: @ints = (3, 1, 4, 13)
Output: false
Example 3
Input: @ints = (2, 1, 4, 2)
Output: true

For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

Task 2: Luhn’s Algorithm
Submitted by: Andrezgz
You are given a string $str containing digits (and possibly other characters which can be ignored). The last digit is the payload; consider it separately. Counting from the right, double the value of the first, third, etc. of the remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on reddit.

Example 1
Input: "17893729974"
Output: true

Payload is 4.

Digits from the right:

7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 9
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 9
8 = 8
7 * 2 = 14, sum = 5
1 = 1

Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.
Example 2
Input: "4137 8947 1175 5904"
Output: true
Example 3
Input: "4137 8974 1175 5904"
Output: false
