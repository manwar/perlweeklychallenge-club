#!/usr/bin/env python

import math

def absent_smallest_positive(arr):
  avg = sum(arr) / len(arr)
  pos = math.ceil(avg)  # smallest integer not less than num
  pos = max(pos, 1)     # require positive number
  if pos == avg: pos+=1 # require strictly greater than num
  while pos in arr: pos+=1 # require num not in array
  return pos

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr):
  print(f'Input: @arr = ({int_join(", ", arr)})')
  print(f'Output: {absent_smallest_positive(arr)}')

print('Example 1:')
solution([1, 2, 4, 5, 6])

print('\nExample 2:')
solution([-5, -2, -1, 3])

print('\nExample 3:')
solution([1, 2, 3])

print('\nExample 4:')
solution([2, 3, 7, 8])

print('\nExample 5:')
solution([1, 1, 1, 10])
