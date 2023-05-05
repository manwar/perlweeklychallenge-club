#!/usr/bin/env python
# -----------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-03
# Challenge 215 Number Placement ( Python )
# -----------------------------------------

numbers = [[1,0,0,0,1],[1,0,0,0,1],[1,0,0,0,0,0,0,0,1]];
counts  = [1,2,3]

cnt=0

def CheckZeroes(arr):
    zcnt = 1;
    while zcnt < len(arr):
        if ((arr[zcnt] == 0) and (arr[zcnt-1] == 0)):
             arr[zcnt] = 1
        zcnt += 1;
    print(f"Output: 1 = {arr}\n")


def HowManyZeroes(arr):
    z = 0
    zcnt = 0
    while z < (len(arr)):
        if (arr[z] == 0):
            zcnt += 1
        z += 1
    return zcnt


for nums in numbers:
    print(f"Input: @numbers = {nums} Count = {counts[cnt]}")
    zeroes = HowManyZeroes(nums)
    if (zeroes < (counts[cnt] * 2)):
        print("Output: 0\n")
    else:
        CheckZeroes(nums)
    cnt += 1
# -----------------------------------------
# SAMPLE OUTPUT
# python .\NumberPlacement.py
# Input: @numbers = [1, 0, 0, 0, 1] Count = 1
# Output: 1 = [1, 0, 1, 0, 1]

# Input: @numbers = [1, 0, 0, 0, 1] Count = 2
# Output: 0

# Input: @numbers = [1, 0, 0, 0, 0, 0, 0, 0, 1] Count = 3
# Output: 1 = [1, 0, 1, 0, 1, 0, 1, 0, 1]
# -----------------------------------------


