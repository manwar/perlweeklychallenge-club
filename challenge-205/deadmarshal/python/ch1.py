#!/usr/bin/env python3

def third_highest(arr):
  arr = sorted(list(set(arr)),reverse=True)
  if len(arr) < 3: return arr[0]
  return arr[2]

print(third_highest([5,3,4]))
print(third_highest([5,6]))
print(third_highest([5,4,4,3]))

