#!/usr/bin/env python

chars = (
  [chr(i) for i in range(ord('0'),ord('9')+1)] +
  [chr(i) for i in range(ord('A'),ord('Z')+1)] +
  [chr(i) for i in range(ord('a'),ord('z')+1)] +
  [ '+', '/' ]
)

def base_n(num, base):
  powers = []
  pow = 0
  while base ** pow < num:
    powers.append(base ** pow)
    pow += 1
  powers.reverse() # reverse the power list
  result = ''
  for pow in powers:
    (d, num) = divmod(num, pow)
    result += chars[d]
  return result

def solution(num, base):
  print(f'Input: $num = {num}, $base = {base}')
  print(f'Output: {base_n(num, base)}')

print('Example 1:')
solution(42, 2)

print('\nExample 2:')
solution(15642094, 16)

print('\nExample 3:')
solution(493, 8)

print('\nExample 4:')
solution(2228519, 36)

print('\nExample 5:')
solution(123456789, 64)
