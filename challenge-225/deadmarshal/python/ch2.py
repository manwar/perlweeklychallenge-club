#!/usr/bin/env python3

def left_right_sum_diff(arr):
  left,right = 0,sum(arr[1:])
  for i in range(len(arr)):
    print(abs(left - right),' ',end=' ')
    left += arr[i]
    if i < len(arr)-1: right -= arr[i+1]
  print()
  
left_right_sum_diff([10,4,8,3])
left_right_sum_diff([1])
left_right_sum_diff([1,2,3,4,5])

