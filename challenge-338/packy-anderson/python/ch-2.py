#!/usr/bin/env python

def max_distance(arr1, arr2):
  (min1, max1) = (min(arr1), max(arr1))
  (min2, max2) = (min(arr2), max(arr2))
  return max(abs(max1 - min2), abs(max2 - min1))

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(arr1, arr2):
  print(f'Input: @arr1 = ({int_join(", ", arr1)})')
  print(f'       @arr2 = ({int_join(", ", arr2)})')
  print(f'Output: {max_distance(arr1, arr2)}')

print('Example 1:')
solution([4, 5, 7], [9, 1, 3, 4])

print('\nExample 2:')
solution([2, 3, 5, 4], [3, 2, 5, 5, 8, 7])

print('\nExample 3:')
solution([2, 1, 11, 3], [2, 5, 10, 2])

print('\nExample 4:')
solution([1, 2, 3], [3, 2, 1])

print('\nExample 5:')
solution([1, 0, 2, 3], [5, 0])
