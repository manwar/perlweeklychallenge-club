#!/usr/bin/env python

from functools import reduce

def add_max(x, y):
  global max_alt
  max_alt = max(max_alt, x+y)
  return x+y

def peak_point(gain):
  global max_alt
  max_alt = 0 # initialize global to 0
  reduce(add_max, gain)
  return max_alt

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(gain):
  print(f'Input: @gain = ({int_join(", ", gain)})')
  print(f'Output: {peak_point(gain)}')

print('Example 1:')
solution([-5, 1, 5, -9, 2])

print('\nExample 2:')
solution([10, 10, 10, -25])

print('\nExample 3:')
solution([3, -4, 2, 5, -6, 1])

print('\nExample 4:')
solution([-1, -2, -3, -4])

print('\nExample 5:')
solution([-10, 15, 5])
