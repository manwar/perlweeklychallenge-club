#!/usr/bin/env python

from collections import Counter

def oneThirdAppearance(ints):
  smallest = None
  oneThird = len(ints) / 3
  seen = Counter()
  for i in ints:
    seen[i] += 1
    if seen[i] >= oneThird:
      if smallest is None or i < smallest:
        smallest = i
  return smallest

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    print(f'Output: { oneThirdAppearance(ints) }')

print('Example 1:')
solution([1,2,3,3,3,3,4,2])

print('\nExample 2:')
solution([1,1])

print('\nExample 3:')
solution([1,2,3])