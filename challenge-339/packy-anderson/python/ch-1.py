#!/usr/bin/env python

def max_diff(ints):
  ints = sorted(ints, key=abs)
  a, b = ints[0:2]
  c, d = ints[-2:]
  return abs((a * b) - (c * d))

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {max_diff(ints)}')

print('Example 1:')
solution([5, 9, 3, 4, 6])

print('\nExample 2:')
solution([1, -2, 3, -4])

print('\nExample 3:')
solution([-3, -1, -2, -4])

print('\nExample 4:')
solution([10, 2, 0, 5, 1])

print('\nExample 5:')
solution([7, 8, 9, 10, 10])
