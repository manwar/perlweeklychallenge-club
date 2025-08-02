#!/usr/bin/env python

def replaceDigits(str):
  last_letter = str[0:1]
  out = ''
  for c in str:
    if c.isnumeric():
      out += chr( ord(last_letter) + int(c) )
    else:
      out += c
      last_letter = c
  return out

def solution(str):
  print(f"Input: $str = '{str}'")
  print(f"Output: '{replaceDigits(str)}'")

print('Example 1:')
solution("a1c1e1")

print('\nExample 2:')
solution("a1b2c3d4")

print('\nExample 3:')
solution("b2b")

print('\nExample 4:')
solution("a16z")
