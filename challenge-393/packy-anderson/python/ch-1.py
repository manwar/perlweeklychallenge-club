#!/usr/bin/env python

import math

def pythag_mult(n):
  count = 0
  sn = int(math.sqrt(n ** 2 / 2))
  for a in range(1, sn+1):
    for b in range(a + 1, n+1):
      c = math.sqrt(a ** 2 + b ** 2)
      if c > n: break
      if c == int(c): count += 2
  return count

def solution(n):
  print(f'Input: $n = {n}')
  print(f'Output: {pythag_mult(n)}')

print('Example 1:')
solution(20)

print('\nExample 2:')
solution(7)

print('\nExample 3:')
solution(1)

print('\nExample 4:')
solution(15)

print('\nExample 5:')
solution(30)
