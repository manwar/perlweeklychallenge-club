#!/usr/bin/env python

def special_numbers(arr):
  ret = []
  for i in range(len(arr)):
    if len(arr) % (i+1) == 0: ret.append(arr[i]**2)
  return sum(ret)

print(special_numbers([1,2,3,4]))
print(special_numbers([2,7,1,19,18,3]))
