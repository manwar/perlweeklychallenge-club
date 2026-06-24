#!/usr/bin/env python

def digits(base, num):
  if num == 0: return [0]
  digits = []
  while num > 0:
    digits.append( num % base )
    num = num // base
  return digits[::-1] # reverse them

def armstrong(base, limit):
  n = 0
  armstrong = []
  while n <= limit:
    dig = digits(base, n)
    pow = len(dig)
    n2  = sum([ d ** pow for d in dig ])
    if n == n2: armstrong.append(n)
    n += 1
  return armstrong

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(base, limit):
  print(f'Input: $base = {base}, $limit = {limit}')
  print(f'Output: ({int_join(", ", armstrong(base, limit))})')

print('Example 1:')
solution(10, 1000)

print('\nExample 2:')
solution(7, 1000)

print('\nExample 3:')
solution(16, 1000)
