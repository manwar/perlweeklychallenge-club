#!/usr/bin/env python

def divisible_average(arr):
  qualifying = [ n for n in arr if not ((n % 2) or (n % 3)) ]
  if not qualifying: return 0
  return round(sum(qualifying) / len(qualifying))

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr):
  print(f'Input: @arr = ({int_join(", ", arr)})')
  print(f'Output: {divisible_average(arr)}')

print('Example 1')
solution([18, 5, 7, 11])

print('\nExample 2')
solution([6, 12, 18, 24, 30, 40])

print('\nExample 3')
solution([3, 9, 15, 21, 27])

print('\nExample 4')
solution([6, 12, 14, 20])

print('\nExample 5')
solution([6, 6, 6, 12, 12])
