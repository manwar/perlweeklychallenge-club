#!/usr/bin/env python

def zero_friend(nums):
  return min([ abs(n) for n in nums])

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(nums):
  print(f'Input: @nums = ({int_join(", ", nums)})')
  print(f'Output: {zero_friend(nums)}')

print('Example 1:')
solution([4, 2, -1, 3, -2])

print('\nExample 2:')
solution([-5, 5, -3, 3, -1, 1])

print('\nExample 3:')
solution([7, -3, 0, 2, -8])

print('\nExample 4:')
solution([-2, -5, -1, -8])

print('\nExample 5:')
solution([-2, 2, -4, 4, -1, 1])
