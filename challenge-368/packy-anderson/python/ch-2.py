#!/usr/bin/env python

import math

def prime_factors(number, mode):
  s = int(math.sqrt(number))
  possible = (
    [2] + # if it's even, 2 is a factor
    [ n for n in range(3, s+3, 2)] # odd nums up to √number
  )
  factors = []
  for i in possible:
    while number % i == 0:
      factors.append(i)
      number /= i
  # if number is prime
  if number > 2: factors.append(number)
  return len(factors) if mode == 1 else len(set(factors))

def solution(number, mode):
  print(f'Input: $number = {number}')
  print(f'       $mode = {mode}')
  print(f'Output: {prime_factors(number, mode)}')

print('Example 1:')
solution(100061, 0)

print('\nExample 2:')
solution(971088, 0)

print('\nExample 3:')
solution(63640, 1)

print('\nExample 4:')
solution(988841, 1)

print('\nExample 5:')
solution(211529, 0)
