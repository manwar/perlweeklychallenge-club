# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/
"""
Task 1: Min Max
Submitted by: Mohammad S Anwar
You are given an array of distinct integers.

Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.

Example 1
Input: @ints = (3, 2, 1, 4)
Output: (3, 2)

The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.
Example 2
Input: @ints = (3, 1)
Output: -1
Example 3
Input: @ints = (2, 1, 3)
Output: (2)

The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.
"""

def notMinMax(lst):
    ret = list(filter(lambda x: x != min(lst) and x != max(lst), lst))
    ret = -1 if len(ret) == 0 else ret
    return ret

for ipt,opt in (
        ([3,2,1,4],[3,2]),
        ([3,1],-1),
        ([2,1,3],[2]),
        ):
    print(notMinMax(ipt)==opt)
