#!/usr/bin/env python

from itertools import permutations

def secret_santa(n):
  valid = []
  for perm in permutations(list(range(1, n+1))):
    is_valid = 1
    for i in range(n):
      if perm[i] == i+1:
        is_valid = 0
        continue
    if is_valid: valid.append(perm)
  return len(valid)

def solution(n):
  print(f'Input: $n = {n}')
  print(f'Output: {secret_santa(n)}')

print('Example 1:')
solution(1)

print('\nExample 2:')
solution(2)

print('\nExample 3:')
solution(3)

print('\nExample 4:')
solution(4)

print('\nExample 5:')
solution(5)
