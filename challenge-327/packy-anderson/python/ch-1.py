#!/usr/bin/env python

def missingInts(ints):
  intSet = set(ints)
  missing = []
  for i in range(1, len(ints)+1):
    if i not in intSet:
      missing.append(i)
  return missing

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  missing = missingInts(ints)
  print(f'Output: ({int_join(", ", missing)})')


print('Example 1:')
solution([1, 2, 1, 3, 2, 5])

print('\nExample 2:')
solution([1, 1, 1])

print('\nExample 3:')
solution([2, 2, 1])
