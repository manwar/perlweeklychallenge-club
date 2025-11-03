#!/usr/bin/env python

def peak_positions(ints):
  peaks = []
  for i in range(len(ints)):
    if not (i == 0           or ints[i - 1] <= ints[i]):
      continue
    if not (i == len(ints)-1 or ints[i + 1] <= ints[i]):
      continue
    peaks.append(i)
  return peaks

def solution(ints):
  print(f'Input: @ints = ({", ".join(map(str, ints))})')
  print(f'Output: ({", ".join(map(str, peak_positions(ints)))})')

print('Example 1:')
solution([1, 3, 2])

print('\nExample 2:')
solution([2, 4, 6, 5, 3])

print('\nExample 3:')
solution([1, 2, 3, 2, 4, 1])

print('\nExample 4:')
solution([5, 3, 1])

print('\nExample 5:')
solution([1, 5, 1, 5, 1, 5, 1])
