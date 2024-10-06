#!/usr/bin/env python

from collections import Counter

def thirdMaximum(ints):
  distinct = Counter(ints) # get distinct integers
  if len(list(distinct)) < 3:
    # not enough values for a third max, return max
    return max(list(distinct))
  # sort and then get the third from the end
  return sorted(list(distinct))[-3]

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @arr = ({comma_join(ints)})')
    print(f'Output: { thirdMaximum(ints) }')

print('Example 1:')
solution([5, 6, 4, 1])

print('\nExample 2:')
solution([4, 5])

print('\nExample 3:')
solution([1, 2, 2, 3])
