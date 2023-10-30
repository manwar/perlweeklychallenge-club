#!/usr/bin/env python

def array_loops(arr):
  i,count,indices = 0,0,[-1] * len(arr)
  while i < len(arr):
    if indices[i] == -1:
      count += 1
      while indices[i] == -1:
        indices[i] = 1
        i = arr[i]
    i += 1
  return count

print(array_loops([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10]))
print(array_loops([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19]))
print(array_loops([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17]))

