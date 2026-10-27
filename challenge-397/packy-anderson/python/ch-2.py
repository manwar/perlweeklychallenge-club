#!/usr/bin/env python

def sort_by_binary_reflection(arr):
  return sorted(arr, key=lambda n: int(bin(n)[2:][::-1], 2))

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr):
  print(f'Input: @arr = ({int_join(", ", arr)})')
  print(f'Output: ({int_join(", ", sort_by_binary_reflection(arr))})')

print('Example 1:')
solution([3, 6, 12])

print('\nExample 2:')
solution([1, 2, 4, 8])

print('\nExample 3:')
solution([7, 8, 9, 10])

print('\nExample 4:')
solution([5, 9, 15, 17])

print('\nExample 5:')
solution([11, 13, 14, 19])
