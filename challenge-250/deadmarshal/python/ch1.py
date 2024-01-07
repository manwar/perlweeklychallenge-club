#!/usr/bin/env python

def smallest_index(arr):
  for i in range(0,len(arr)):
    if i % 10 == arr[i]: return i
  return -1
  
print(smallest_index([0,1,2]))
print(smallest_index([4,3,2,1]))
print(smallest_index([1,2,3,4,5,6,7,8,9,0]))

