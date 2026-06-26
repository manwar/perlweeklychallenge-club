#!/usr/bin/env python

def sop(ints):
  n = len(ints)
  for i in range(n):
    if ints[i] == 1: pos_one = i
    if ints[i] == n: pos_n   = i
  if pos_one < pos_n:
    return pos_one + (n-1) - pos_n
  else:
    return pos_one + (n-1) - pos_n - 1

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {sop(ints)}')

print('Example 1:')
solution([2, 1, 4, 3])

print('\nExample 2:')
solution([2, 4, 1, 3])

print('\nExample 3:')
solution([1, 3, 2, 4, 5])

print('\nExample 4:')
solution([5, 4, 3, 2, 1])

print('\nExample 5:')
solution([3, 1, 6, 4, 5, 7, 2])
