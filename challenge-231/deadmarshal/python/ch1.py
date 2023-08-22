#!/usr/bin/env python3

def min_max(arr):
  mn,mx = min(arr),max(arr)
  return list(filter(lambda n: n != mn and n != mx,arr))

print(min_max([3,2,1,4]))
print(min_max([3,1]))
print(min_max([2,1,3]))

