#!/usr/bin/env python

import string

def rot_n(s, n):
  n = n % 26 # 0 <= n < 26
  orig = string.ascii_lowercase
  shifted = orig[n:] + orig[:n]
  return s.translate(str.maketrans(orig, shifted))

def solution(s, n):
  print(f'Input: $str = "{s}", $int = {n}')
  print(f'Output: "{rot_n(s, n)}"')

print('Example 1:')
solution("abc", 1)

print('\nExample 2:')
solution("xyz", 2)

print('\nExample 3:')
solution("abc", 27)

print('\nExample 4:')
solution("hello", 5)

print('\nExample 5:')
solution("perl", 26)