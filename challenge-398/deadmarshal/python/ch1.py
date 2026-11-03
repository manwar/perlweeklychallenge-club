#!/usr/bin/env python3

def divisible_average(arr):
  f = [x for x in arr if x % 2 == 0 and x % 3 == 0]
  if not f:
    return 0
  return sum(f) // len(f)

print(divisible_average([18,5,7,11]))
print(divisible_average([6,12,18,24,30,40]))
print(divisible_average([3,9,15,21,27]))
print(divisible_average([6,12,14,20]))
print(divisible_average([6,6,6,12,12]))

