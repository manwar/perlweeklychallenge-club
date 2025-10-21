#!/usr/bin/env python

def compute(ints, x):
  return list(str(int("".join(map(str, ints))) + x))

def solution(ints, x):
  print(f'Input: @ints = ({"".join(map(str, ints))}), $x = {x}')
  print(f'Output: ({"".join(map(str, compute(ints, x)))})')


print('Example 1:')
solution([1, 2, 3, 4], 12)

print('\nExample 2:')
solution([2, 7, 4], 181)

print('\nExample 3:')
solution([9, 9, 9], 1)

print('\nExample 4:')
solution([1, 0, 0, 0, 0], 9999)

print('\nExample 5:')
solution([0], 1000)
