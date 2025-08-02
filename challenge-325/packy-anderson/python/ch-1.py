#!/usr/bin/env python

def consecutiveOne(binary):
  max_c = 0
  consecutive = 0
  for bit in binary:
    if bit == 1:
      consecutive += 1
      if consecutive > max_c: max_c = consecutive
    else:
      consecutive = 0
  return max_c

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(binary):
  print(f'Input: @binary = ({int_join(", ", binary)})')
  print(f'Output: {consecutiveOne(binary)}')


print('Example 1:')
solution([0, 1, 1, 0, 1, 1, 1])

print('\nExample 2:')
solution([0, 0, 0, 0])

print('\nExample 3:')
solution([1, 0, 1, 0, 1, 1])

print('\nExample 4:')
solution([1, 1, 1, 0, 1, 1, 0])

print('\nExample 5:')
solution([1, 0, 1, 1, 0, 1, 0])
