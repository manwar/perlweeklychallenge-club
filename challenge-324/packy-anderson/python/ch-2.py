#!/usr/bin/env python

from functools import reduce

def powerSet(ints):
  return reduce(lambda r, i: r + [s + [i] for s in r], ints, [[]])

def totalXOR(ints):
  sum = 0
  for s in powerSet(ints):
    sum += reduce(lambda a, b: a ^ b, s, 0)
  return sum

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {totalXOR(ints)}')

print('Example 1:')
solution([1, 3])

print('\nExample 2:')
solution([5, 1, 6])

print('\nExample 3:')
solution([3, 4, 5, 6, 7, 8])
