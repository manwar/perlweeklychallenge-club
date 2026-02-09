Challenge 345
https://theweeklychallenge.org/blog/perl-weekly-challenge-345/

Task 1: Peak Positions
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Find all the peaks in the array, a peak is an element that is strictly greater than its left and right neighbours. Return the indices of all such peak positions.


Example 1
Input: @ints = (1, 3, 2)
Output: (1)

Example 2
Input: @ints = (2, 4, 6, 5, 3)
Output: (2)

Example 3
Input: @ints = (1, 2, 3, 2, 4, 1)
Output: (2, 4)

Example 4
Input: @ints = (5, 3, 1)
Output: (0)

Example 5
Input: @ints = (1, 5, 1, 5, 1, 5, 1)
Output: (1, 3, 5)

Task 2: Last Visitor
Submitted by: Mohammad Sajid Anwar
You are given an integer array @ints where each element is either a positive integer or -1.

We process the array from left to right while maintaining two lists:

@seen: stores previously seen positive integers (newest at the front)
@ans: stores the answers for each -1
Rules:

If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:
Let $x be how many -1s in a row we’ve seen before this one.

If $x < len(@seen) -> append seen[x] to @ans

Else -> append -1 to @ans

At the end, return @ans.


Example 1
Input: @ints = (5, -1, -1)
Output: (5, -1)

@seen = (5)
First  -1: @ans = (5)
Second -1: @ans = (5, -1)

Example 2
Input: @ints = (3, 7, -1, -1, -1)
Output: (7, 3, -1)

@seen = (3, 7)
First  -1: @ans = (7)
Second -1: @ans = (7, 3)
Third  -1: @ans = (7, 3, -1)

Example 3
Input: @ints = (2, -1, 4, -1, -1)
Output: (2, 4, 2)

Example 4
Input: @ints = (10, 20, -1, 30, -1, -1)
Output: (20, 30, 20)

Example 5
Input: @ints = (-1, -1, 5, -1)
Output: (-1, -1, 5)
