Challenge 361
https://theweeklychallenge.org/blog/perl-weekly-challenge-361/

Task 1: Zeckendorf Representation
Submitted by: Mohammad Sajid Anwar
You are given a positive integer (<= 100).

Write a script to return Zeckendorf Representation of the given integer.

Every positive integer can be uniquely represented as sum of non-consecutive Fibonacci numbers.

Example 1
Input: $int = 4
Output: 3,1

4 => 3 + 1 (non-consecutive fibonacci numbers)

Example 2
Input: $int = 12
Output: 8,3,1

12 => 8 + 3 + 1

Example 3
Input: $int = 20
Output: 13,5,2

20 => 13 + 5 + 2

Example 4
Input: $int = 96
Output: 89,5,2

96 => 89 + 5 + 2

Example 5
Input: $int = 100
Output: 89,8,3

100 => 89 + 8 + 3

Task 2: Find Celebrity
Submitted by: Mohammad Sajid Anwar
You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

A celebrity is someone, everyone knows and knows nobody.

Example 1
Input: @party = (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       );
Output: 4

Example 2
Input: @party = (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       );
Output: -1

Example 3
Input: @party = (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       );
Output: 0

Example 4
Input: @party = (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       );
Output: 3

Example 5
Input: @party = (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       );
Output: -1

Example 6
Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1
