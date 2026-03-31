Perl Weekly Challenge 188
https://theweeklychallenge.org/blog/perl-weekly-challenge-188/

Task 1: Divisible Pairs
Submitted by: Mohammad S Anwar
You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the following rules.

The pair (i, j) is eligible if and only if
a) 0 <= i < j < len(list)
b) list[i] + list[j] is divisible by k

Example 1
Input: @list = (4, 5, 1, 6), $k = 2
Output: 2

Example 2
Input: @list = (1, 2, 3, 4), $k = 2
Output: 2

Example 3
Input: @list = (1, 3, 4, 5), $k = 3
Output: 2

Example 4
Input: @list = (5, 1, 2, 3), $k = 4
Output: 2

Example 5
Input: @list = (7, 2, 4, 5), $k = 4
Output: 1


Task 2: Total Zero
Submitted by: Mohammad S Anwar
You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:

$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)

Example 1
Input: $x = 5, $y = 4
Output: 5

Example 2
Input: $x = 4, $y = 6
Output: 3

Example 3
Input: $x = 2, $y = 5
Output: 4

Example 4
Input: $x = 3, $y = 1
Output: 3

Example 5
Input: $x = 7, $y = 4
Output: 5
