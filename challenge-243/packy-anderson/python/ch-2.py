#!/usr/bin/env python

from math import trunc

def floorSum(nums):
    sum = 0;
    for i in range(0, len(nums)):
        for j in range(0, len(nums)):
            sum += trunc(nums[i] / nums[j])
    return sum

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(nums):
    print(f'Input: @nums = ({comma_join(nums)})')
    sum = floorSum(nums)
    print(f'Output: {sum}')

print('Example 1:')
solution([2, 5, 9])

print('\nExample 2:')
solution([7, 7, 7, 7, 7, 7, 7])
