#!/usr/bin/env python

from functools import cache

@cache
def setBitCount(i):
  count = 0
  bit   = 1
  while (bit <= i):
    if i & bit: count += 1 # count if we have this bit set
    bit <<= 1 # shift bits left, ie 10 becomes 100
  return count

def valueSum(k, ints):
  sum = 0
  for i in range(len(ints)):
    if setBitCount(i) == k: sum += ints[i]
  return sum

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(k, ints):
    print(f'Input: @ints = ({comma_join(ints)}), $k = {k}')
    print(f'Output: {valueSum(k, ints)}')

print('Example 1:')
solution(1, [2, 5, 9, 11, 3])

print('\nExample 2:')
solution(2, [2, 5, 9, 11, 3])

print('\nExample 3:')
solution(0, [2, 5, 9, 11, 3])
