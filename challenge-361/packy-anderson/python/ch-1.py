#!/usr/bin/env python

def largest_fibo_le(i):
  x, y = 0, 1
  while y <= i:
    x, y = y, x + y
  return x

def zeckendorf(i):
  # the largest element is the first number
  # in the Zeckendorf form
  largest = largest_fibo_le(i)
  z = [largest]

  if largest == i: return z

  # if we need more elements, use recursion to find them
  z.extend( zeckendorf( i - largest ) )
  return z

def solution(i):
  print(f'Input: $int = {i}')
  z = zeckendorf(i)
  print(f'Output: {",".join(map(str, z))}')
  print(f'\n{i} => {" + ".join(map(str, z))}')

print('Example 1:')
solution(4)

print('\nExample 2:')
solution(12)

print('\nExample 3:')
solution(20)

print('\nExample 4:')
solution(96)

print('\nExample 5:')
solution(100)
