#!/usr/bin/env python
'''
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-04
Challenge 211 Split Same Average ( Python )
----------------------------------------
'''
from itertools import combinations
import functools
import operator

nums = [1,2,3,4,5,6,7,8]
flag = 0

for ndx in range(1,5):
    print("Set size = ",ndx)
    print("Input: @nums = ", nums)
    mycheck = False
    Set1 = set(nums)
    for s2 in combinations(Set1,ndx):
        Set2 = ((s2))
        Set3 = Set1.difference(Set2)
        s2 = functools.reduce(operator.add, Set2)/len(Set2)
        s3 = functools.reduce(operator.add, Set3)/len(Set3)
        if s2 == s3:
            print(Set2,' ',Set3,' ',s2,' ',s3)
            flag = 1
    print("Output: true") if (flag==1) else print("output: false")
    flag = 0

    print('')

'''
----------------------------------------
SAMPLE OUTPUT
python .\SplitSame.py
Set size =  1
Input: @nums =  [1, 2, 3, 4, 5, 6, 7, 8]
output: false

Set size =  2
Input: @nums =  [1, 2, 3, 4, 5, 6, 7, 8]
(1, 8)   {2, 3, 4, 5, 6, 7}   4.5   4.5
(2, 7)   {1, 3, 4, 5, 6, 8}   4.5   4.5
(3, 6)   {1, 2, 4, 5, 7, 8}   4.5   4.5
(4, 5)   {1, 2, 3, 6, 7, 8}   4.5   4.5
Output: true

Set size =  3
Input: @nums =  [1, 2, 3, 4, 5, 6, 7, 8]
output: false

Set size =  4
Input: @nums =  [1, 2, 3, 4, 5, 6, 7, 8]
(1, 2, 7, 8)   {3, 4, 5, 6}   4.5   4.5
(1, 3, 6, 8)   {2, 4, 5, 7}   4.5   4.5
(1, 4, 5, 8)   {2, 3, 6, 7}   4.5   4.5
(1, 4, 6, 7)   {2, 3, 5, 8}   4.5   4.5
(2, 3, 5, 8)   {1, 4, 6, 7}   4.5   4.5
(2, 3, 6, 7)   {1, 4, 5, 8}   4.5   4.5
(2, 4, 5, 7)   {1, 3, 6, 8}   4.5   4.5
(3, 4, 5, 6)   {1, 2, 7, 8}   4.5   4.5
Output: true
----------------------------------------



'''


