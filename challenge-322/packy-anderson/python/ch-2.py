#!/usr/bin/env python

def rankArray(ints):
  rankInt = 0
  rankDict = {}
  for i in sorted(ints):
    if i in rankDict: continue
    rankInt += 1
    rankDict[i] = rankInt
  return [ rankDict[i] for i in ints ]

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: ({int_join(", ", rankArray(ints))})')


print('Example 1:')
solution([55, 22, 44, 33])

print('\nExample 2:')
solution([10, 10, 10])

print('\nExample 3:')
solution([5, 1, 1, 4, 3])
