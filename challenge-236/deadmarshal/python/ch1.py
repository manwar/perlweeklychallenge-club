#!/usr/bin/env python

def exact_change(arr):
  h = {}
  for i in range(0,len(arr)):
    if arr[i] == 10:
      h[5] = h.get(5,0) - 1
      if h[5] == 0: return False
    elif arr[i] == 20:
      if h.get(5,0) != 0 and h.get(10,0) != 0:
        h[5] -= 1
        h[10] -= 1
      elif h.get(5,0) > 2:
        h[5] -= 3
      else:
        return False
    h[arr[i]] = h.get(arr[i],0) + 1
  return True

print(exact_change([5,5,5,10,20]))
print(exact_change([5,5,10,10,20]))
print(exact_change([5,5,5,20]))

