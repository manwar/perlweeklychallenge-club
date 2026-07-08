#!/usr/bin/env python

from collections import Counter

def smaller_greater(ints):
  bag = Counter(ints)
  keys = bag.keys()
  if len(keys) < 3: return 0 # not enough unique elements
  (min_k, max_k) = (min(keys), max(keys))
  del bag[ min_k ] # the smallest
  del bag[ max_k ] # the greatest
  return bag.total()

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(ints):
  print(f'Input: @int = ({int_join(", ", ints)})')
  print(f'Output: {smaller_greater(ints)}')

print('Example 1:')
solution([2, 4])

print('\nExample 2:')
solution([1, 1, 1, 1])

print('\nExample 3:')
solution([1, 1, 4, 8, 12, 12])

print('\nExample 4:')
solution([3, 6, 6, 9])

print('\nExample 5:')
solution([0, -5, 10, -2, 4])
