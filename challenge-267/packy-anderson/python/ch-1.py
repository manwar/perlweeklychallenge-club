#!/usr/bin/env python

from functools import reduce

def productSign(ints):
  product = reduce(lambda a, b: a * b, ints)
  sign = 0 if product == 0 else int(product / abs(product))

  explain = (
    'The product ' + ' × '.join(map(lambda i: str(i), ints))
    + ' => ' + str(product)
  )
  if (sign < 0): explain += " < 0"
  if (sign > 0): explain += " > 0"

  return (sign, explain)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    sign, explain = productSign(ints)
    print(f'Output: {sign}\n{explain}')

print('Example 1:')
solution([-1, -2, -3, -4, 3, 2, 1])

print('\nExample 2:')
solution([1, 2, 0, -2, -1])

print('\nExample 3:')
solution([-1, -1, 1, -1, 2])