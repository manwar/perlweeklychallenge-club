#!/usr/bin/env python
'''
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-06
Challenge 237 Task 02 Maximise Greatness ( Python )
-----------------------------------------
'''

from itertools import permutations
import math

mynums = [[1, 3, 5, 2, 1, 3, 1], [1, 2, 3, 4]]

maxscore = 0;
score = 0;

def CalcScore(a,b):
    cnt = 0
    score = 0
    while cnt < len(a):
        if a[cnt] < b[cnt]:
            score += 1
        cnt += 1
    return score

for nums in mynums:
    print(f"Input: @nums = {nums}")
    maxscore = 0
    p = permutations(nums)
    for perm in list(p):
        score = CalcScore(nums, perm)
        ignore = math.floor(len(nums) / 2 + 1)
        if score >= maxscore and score >= ignore:
            maxscore = score
    print(f"Output: {maxscore}\n")

'''
-----------------------------------------
SAMPLE OUTPUT
python .\MaximiseGreatness.py

Input: @nums = [1, 3, 5, 2, 1, 3, 1]
Output: 4

Input: @nums = [1, 2, 3, 4]
Output: 3
-----------------------------------------
'''


