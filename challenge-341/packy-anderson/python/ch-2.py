#!/usr/bin/env python

def distinctAverages(nums):
  pass

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(nums):
  print(f'Input: @nums = ({int_join(", ", nums)})')
  count, explain = distinctAverages(nums)
  print(f'Output: {count}\n\n{explain}')


print('Example 1:')
solution()

print('\nExample 2:')
solution()

print('\nExample 3:')
solution()

print('\nExample 4:')
solution()

print('\nExample 5:')
solution()
