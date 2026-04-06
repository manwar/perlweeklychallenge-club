#!/usr/bin/env python

def max_odd_binary(mystr):
  bits = list(reversed(sorted([ b for b in mystr ])))
  bits.append(bits.pop(0))
  return ''.join(bits)

def solution(mystr):
  print(f'Input: $str = "{mystr}"')
  print(f'Output: "{max_odd_binary(mystr)}"')

print('Example 1:')
solution("1011")

print('\nExample 2:')
solution("100")

print('\nExample 3:')
solution("111000")

print('\nExample 4:')
solution("0101")

print('\nExample 5:')
solution("1111")
