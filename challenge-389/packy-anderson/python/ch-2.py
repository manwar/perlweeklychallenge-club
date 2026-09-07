#!/usr/bin/env python

from functools import cache

@cache
def is_zig_zag(nums):
  # base cases
  if len(nums) == 1: return True
  if len(nums) == 2: return nums[0] != nums[1]

  # it's not ZigZag if the array isn't ZigZag before last element
  if not is_zig_zag(tuple(nums[0:-1])): return False
  return (
    (nums[-3] > nums[-2] and nums[-2] < nums[-1])
    or
    (nums[-3] < nums[-2] and nums[-2] > nums[-1])
  )

def longest_zig_zag(nums):
  current, longest = [], []
  for i in range(len(nums)):
    # put the $i-th element onto the current subset
    current.append(nums[i])
    if is_zig_zag(tuple(current)):
      if len(current) > len(longest):
        longest = current.copy()
    else:
      # pull elements off the front until it's ZigZag again
      while not is_zig_zag(tuple(current)):
        current.pop(0)
  return len(longest), longest

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(nums):
  print(f'Input: @nums = ({int_join(", ", nums)})')
  length, longest = longest_zig_zag(nums)
  print(f'Output: {length}\n')
  print(f'ZigZag subarray: ({int_join(", ", longest)})')

print('Example 1:')
solution([9, 4, 2, 10, 7, 8, 8, 1, 9])

print('\nExample 2:')
solution([1, 7, 4, 9, 2, 5])

print('\nExample 3:')
solution([1, 2, 3, 4, 5])

print('\nExample 4:')
solution([4, 4, 4])

print('\nExample 5:')
solution([10, 20, 15, 12, 18])
