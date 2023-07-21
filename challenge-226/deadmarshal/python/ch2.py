#!/usr/bin/env python3

def zero_array(arr):
  return len(set(filter(lambda x: x != 0, arr)))

print(zero_array([1,5,0,3,5]))
print(zero_array([0]))
print(zero_array([2,1,4,0,3]))

