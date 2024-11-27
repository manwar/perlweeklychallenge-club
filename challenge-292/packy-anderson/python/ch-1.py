#!/usr/bin/env python

def twiceLargest(ints):
  if len(ints) <= 1:
    return -1
  largest = 0
  second = -1
  for i in range(1, len(ints)):
    if ints[i] > ints[largest]:
      second  = largest
      largest = i
    elif second < 0 or ints[i] > ints[second]:
      second = i
  return largest if ints[largest] >= 2 * ints[second] else -1

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @inst = ({comma_join(ints)})')
  print(f'Output: { twiceLargest(ints) }')

print('Example 1:')
solution([2, 4, 1, 0])

print('\nExample 2:')
solution([1, 2, 3, 4])

print('\nExample 3:')
solution([1])

print('\nExample 4:')
solution([4, 2, 1])
