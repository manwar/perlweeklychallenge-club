#!/usr/bin/env python

def array_median(arr1, arr2):
  merged = []
  while arr1 and arr2:
    v1, v2 = arr1.pop(0), arr2.pop(0)
    if v1 < v2:
      merged.append(v1)
      arr2.insert(0, v2)
    else:
      merged.append(v2)
      arr1.insert(0, v1)
  merged.extend(arr1)
  merged.extend(arr2)
  l = len(merged)
  if l % 2 == 1:
    return merged[l // 2] / 1 # make it a float
  else:
    mid = (l // 2) - 1
    return (merged[mid] + merged[mid+1]) / 2

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr1, arr2):
  print(f'Input: @arr1 = ({int_join(", ", arr1)}), '+
        f'@arr2 = ({int_join(", ", arr2)})')
  print(f'Output: {array_median(arr1, arr2)}')

print('Example 1:')
solution([2],[4])

print('\nExample 2:')
solution([1,2,3],[7,8,9,10])

print('\nExample 3:')
solution([],[10,20,30,40])

print('\nExample 4:')
solution([100],[1,2,3,4,5,6,7])

print('\nExample 5:')
solution([1,2,2],[2,2,3])
