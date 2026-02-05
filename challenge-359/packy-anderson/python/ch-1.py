#!/usr/bin/env python

def digital_root(my_int, persistence=0):
  if my_int < 10: return (persistence, my_int)
  my_sum = sum(int(digit) for digit in str(my_int))
  return digital_root(my_sum, persistence + 1)

def solution(my_int):
  print(f'Input: $int = {my_int}')
  persistence, root = digital_root(my_int)
  print(f'Output: Persistence  = {persistence}')
  print(f'        Digital Root = {root}')

print('Example 1:')
solution(38)

print('\nExample 2:')
solution(7)

print('\nExample 3:')
solution(999)

print('\nExample 4:')
solution(1999999999)

print('\nExample 5:')
solution(101010)