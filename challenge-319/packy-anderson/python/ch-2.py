#!/usr/bin/env python

def minCommon(arr1, arr2):
  set1   = set(arr1)
  set2   = set(arr2)
  common = set1.intersection(set2)
  if common:
    return min(list(common))
  return -1

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(arr1, arr2):
    print(f'Input: @array_1 = ({comma_join(arr1)})')
    print(f'       @array_2 = ({comma_join(arr2)})')
    print(f'Output: { minCommon(arr1, arr2 )}')

print('Example 1:')
solution([1, 2, 3, 4], [3, 4, 5, 6])

print('\nExample 2:')
solution([1, 2, 3], [2, 4])

print('\nExample 3:')
solution([1, 2, 3, 4], [5, 6, 7, 8])
