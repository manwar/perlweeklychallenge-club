#!/usr/bin/env python

from collections import UserList

class ReversePairArray(UserList):
    def isReversePair(self, i, j):
        return self.data[i] > 2 * self.data[j]

def findReversePairs(nums):
    pairs = []
    rpArray = ReversePairArray(nums)
    for i in range(0, len(nums) - 1):
        for j in range(i+1, len(nums)):
            if rpArray.isReversePair(i, j):
                pairs.append([i, j])
    return pairs

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(nums):
    print(f'Input: @nums = ({comma_join(nums)})')
    pairs = findReversePairs(nums)
    print(f'Output: {len(pairs)}')
    for pair in pairs:
        (i, j) = pair
        print(f'({i}, {j}) => ', end='')
        print(f'nums[{i}] = {nums[i]}, ', end='')
        print(f'nums[{j}] = {nums[j]}, ', end='')
        print(f'{nums[i]} > 2 * {nums[j]}')

print('Example 1:')
solution([1, 3, 2, 3, 1])

print('\nExample 2:')
solution([2, 4, 3, 5, 1])
