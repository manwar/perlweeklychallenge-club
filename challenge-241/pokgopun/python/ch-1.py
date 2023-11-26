### https://theweeklychallenge.org/blog/perl-weekly-challenge-241/
"""

Task 1: Arithmetic Triplets

Submitted by: [42]Mohammad S Anwar
     __________________________________________________________________

   You are given an array (3 or more members) of integers in increasing
   order and a positive integer.

   Write a script to find out the number of unique Arithmetic Triplets
   satisfying the following rules:
a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff

Example 1

Input: @nums = (0, 1, 4, 6, 7, 10)
       $diff = 3
Output: 2

Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3
.
Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3
.

Example 2

Input: @nums = (4, 5, 6, 7, 8, 9)
       $diff = 2
Output: 2

(0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
(1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.

Task 2: Prime Order
"""
### solution by pokgopun@gmail.com

from itertools import combinations

def cntArmtcTrplt(nums: tuple, diff: int):
    return len(
            tuple(
                filter(lambda x: x[1] - x[0] == diff and 2*x[1] == x[0] + x[2], combinations(nums,3))
                )
            )

for (num, diff), count in {
        ((0, 1, 4, 6, 7, 10), 3): 2,
        ((4, 5, 6, 7, 8, 9), 2): 2,
        }.items():
    print(cntArmtcTrplt(num,diff)==count)
