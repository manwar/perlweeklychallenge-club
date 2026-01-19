#!/usr/bin/env python

def fractions(num):
  if num == 1: return [ (1, 1), ]
  lst = [ (1, num), (num, 1) ]
  digits = [2] if num == 2 else range(2, num)
  for digit in digits:
    if num % digit == 0: continue
    lst.extend([(digit, num), (num, digit)])
  lst.extend(fractions(num-1))
  return lst

def tuple_to_fraction(tupl):
  numerator,denominator = tupl
  return numerator / denominator

def uniq_fractions(num):
  return ", ".join([
    f'{numerator}/{denominator}' for numerator,denominator in
    sorted(fractions(num), key=tuple_to_fraction)
  ])

def solution(num):
  print(f'Input: $int = {num}')
  print(f'Output: ' + uniq_fractions(num))

print('Example 1:')
solution(3)

print('\nExample 2:')
solution(4)

print('\nExample 3:')
solution(1)

print('\nExample 4:')
solution(6)

print('\nExample 5:')
solution(5)
