### https://theweeklychallenge.org/blog/perl-weekly-challenge-237/
"""

Task 2: Maximise Greatness

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to permute the give array such that you get the maximum
   possible greatness.

     To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length

Example 1

Input: @nums = (1, 3, 5, 2, 1, 3, 1)
Output: 4

One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as bel
ow:
nums[0] < perm[0]
nums[1] < perm[1]
nums[3] < perm[3]
nums[4] < perm[4]

Example 2

Input: @ints = (1, 2, 3, 4)
Output: 3

One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
nums[0] < perm[0]
nums[1] < perm[1]
nums[2] < perm[2]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th October
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import permutations

def maxGreat(tup):
    l, m = len(tup), 0
    for pm in permutations(tup):
        g = tuple( pm[i] > tup[i] for i in range(l) ).count(True)
        if m < g : m = g
    return m

for inpt,otpt in {
        (1, 3, 5, 2, 1, 3, 1): 4,
        (1, 2, 3, 4): 3,
        }.items():
    print(maxGreat(inpt)==otpt)


