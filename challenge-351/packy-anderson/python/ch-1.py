#!/usr/bin/env python

def special_average(ints):
  minv = min(ints) # ok, using built-in functions to
  maxv = max(ints) # find min/max rather than a loop
  ints = [ i for i in ints if i != minv and i != maxv ]
  if len(ints) == 0: return 0
  return int(sum(ints) / len(ints))

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {special_average(ints)}')

print('Example 1:')
solution([8000, 5000, 6000, 2000, 3000, 7000])

print('\nExample 2:')
solution([100_000, 80_000, 110_000, 90_000])

print('\nExample 3:')
solution([2500, 2500, 2500, 2500])

print('\nExample 4:')
solution([2000])

print('\nExample 5:')
solution([1000, 2000, 3000, 4000, 5000, 6000])
