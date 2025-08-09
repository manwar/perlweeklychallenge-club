#!/usr/bin/env python

def duplicate_zeros(ints):
  size = len(ints)
  dest = []
  while len(dest) < size:
    i = ints.pop(0)
    dest.append(i)
    if i == 0: dest.append(i)
  return dest[0:size]

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: ({int_join(", ", duplicate_zeros(ints))})')

print('Example 1:')
solution([1, 0, 2, 3, 0, 4, 5, 0])

print('\nExample 2:')
solution([1, 2, 3])

print('\nExample 3:')
solution([1, 2, 3, 0])

print('\nExample 4:')
solution([0, 0, 1, 2])

print('\nExample 5:')
solution([1, 2, 0, 3, 4])
