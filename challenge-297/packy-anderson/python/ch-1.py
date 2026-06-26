#!/usr/bin/env python

def contiguous_array(arr):
  # special case: all 0s or all 1s
  alen = len(arr)
  asum = sum(arr)
  if asum == 0 or asum == alen: return 0
  
  # special case: entire array is equal
  if asum == alen/2: return alen

  # generate subarrays and check
  amax = 0
  for i in range(alen - 1):
    for j in range(i+1, alen):
      subarr = arr[i:j]
      if (sum(subarr) == len(subarr)/2):
        amax = max(amax, len(subarr))
  return amax

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr):
  print(f'Input: @arr = ({int_join(", ", arr)})')
  print(f'Output: {contiguous_array(arr)}')

print('Example 1:')
solution([1, 0])

print('\nExample 2:')
solution([0, 1, 0])

print('\nExample 3:')
solution([0, 0, 0, 0, 0])

print('\nExample 4:')
solution([0, 1, 0, 0, 1, 0])

print('\nExample 5:')
solution([1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1])
