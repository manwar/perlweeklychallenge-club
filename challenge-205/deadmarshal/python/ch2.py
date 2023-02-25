#!/usr/bin/env python3

def maximum_xor(arr):
  mx = 0
  for i in range(0,len(arr)):
    for j in range(0,len(arr)):
      temp = arr[i] ^ arr[j]
      if mx < temp: mx = temp
  return mx

print(maximum_xor([1,2,3,4,5,6,7]))
print(maximum_xor([2,4,1,3]))
print(maximum_xor([10,5,7,12,8]))

