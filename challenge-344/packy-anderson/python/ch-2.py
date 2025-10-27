#!/usr/bin/env python

from itertools import permutations

def formation(source, target):
  source = [ "".join(map(str, s)) for s in source ]
  target = "".join(map(str, target))
  for perm in permutations(source):
    if "".join(perm) == target: return 'true'
  return 'false'

def solution(source, target):
  arr = [ "[" + ",".join(map(str, s)) + "]" for s in source ]
  print(f'Input: @source = ({arr})')
  print(f'       @target = ({", ".join(map(str, target))})')
  print(f'Output: {formation(source, target)}')

print('Example 1:')
solution([[2,3], [1], [4]], [1, 2, 3, 4])

print('\nExample 2:')
solution([[1,3], [2,4]], [1, 2, 3, 4])

print('\nExample 3:')
solution([[9,1], [5,8], [2]], [5, 8, 2, 9, 1])

print('\nExample 4:')
solution([[1], [3]], [1, 2, 3])

print('\nExample 5:')
solution([[7,4,6]], [7,4,6])
