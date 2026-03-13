Challenge 249
https://theweeklychallenge.org/blog/perl-weekly-challenge-249/

Task 1: Equal Pairs
Submitted by: Mohammad S Anwar
You are given an array of integers with even number of elements.

Write a script to divide the given array into equal pairs such that:

a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.


Example 1
Input: @ints = (3, 2, 3, 2, 2, 2)
Output: (2, 2), (3, 3), (2, 2)

There are 6 elements in @ints.
They should be divided into 6 / 2 = 3 pairs.
@ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the conditions.

Example 2
Input: @ints = (1, 2, 3, 4)
Output: ()

There is no way to divide @ints 2 pairs such that the pairs satisfy every condition.


Task 2: DI String Match
Submitted by: Mohammad S Anwar
You are given a string s, consisting of only the characters "D" and "I".

Find a permutation of the integers [0 .. length(s)] such that for each character s[i] in the string:

s[i] == 'I' ? perm[i] < perm[i + 1]
s[i] == 'D' ? perm[i] > perm[i + 1]


Example 1
Input: $str = "IDID"
Output: (0, 4, 1, 3, 2)

Example 2
Input: $str = "III"
Output: (0, 1, 2, 3)

Example 3
Input: $str = "DDI"
Output: (3, 2, 0, 1)
