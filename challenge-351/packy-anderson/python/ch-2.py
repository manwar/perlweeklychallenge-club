#!/usr/bin/env python

def arithmetic_progression(ints):
  ints = sorted(ints)
  prev = ints.pop(0)
  diff = ints[0] - prev # calc first difference
  for cur in ints:
    if diff != cur - prev: return False
    prev = cur
  return True

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {arithmetic_progression(ints)}')

print('Example 1:')
solution([1, 3, 5, 7, 9])

print('\nExample 2:')
solution([9, 1, 7, 5, 3])

print('\nExample 3:')
solution([1, 2, 4, 8, 16])

print('\nExample 4:')
solution([5, -1, 3, 1, -3])

print('\nExample 5:')
solution([1.5, 3, 0, 4.5, 6])
