Challenge 300
https://theweeklychallenge.org/blog/perl-weekly-challenge-300/

Task 1: Beautiful Arrangement
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int.

Write a script to return the number of beautiful arrangements that you can construct.

A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

1) perm[i] is divisible by i
2) i is divisible by perm[i]
Example 1
Input: $n = 2
Output: 2

1st arrangement: [1, 2]
    perm[1] is divisible by i = 1
    perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
    perm[1] is divisible by i = 1
    i=2 is divisible by perm[2] = 1
Example 2
Input: $n = 1
Output: 1
Example 3
Input: $n = 10
Output: 700

Task 2: Nested Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints of length n containing permutation of the numbers in the range [0, n - 1].

Write a script to build a set, set[i] = ints[i], ints[ints[i]], ints[ints[ints[i]]], ..., subjected to the following rules:

1. The first element in set[i] starts with the selection of elements ints[i].
2. The next element in set[i] should be ints[ints[i]], and then ints[ints[ints[i]]], and so on.
3. We stop adding right before a duplicate element occurs in set[i].
Return the longest length of a set set[i].

Example 1
Input: @ints = (5, 4, 0, 3, 1, 6, 2)
Output: 4

ints[0] = 5
ints[1] = 4
ints[2] = 0
ints[3] = 3
ints[4] = 1
ints[5] = 6
ints[6] = 2

One of the longest sets set[k]:
set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}
Example 2
Input: @ints = (0, 1, 2)
Output: 1
