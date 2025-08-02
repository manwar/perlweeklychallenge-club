#!/usr/bin/env python

def unique_sum_zero(n):
  ret = []
  for i in range(1,n//2+1):
    ret += [i,-i]
  if n % 2 != 0: ret.append(0)
  return ret

print(unique_sum_zero(5))
print(unique_sum_zero(3))
print(unique_sum_zero(1))
