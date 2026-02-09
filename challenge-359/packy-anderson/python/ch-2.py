#!/usr/bin/env python

import re

def string_reduction(word):
  while True:
    word, n = re.subn(r'(.)\1', '', word)
    if n == 0: break
  return word

def solution(word):
  print(f'Input: $word = "{word}"')
  print(f'Output: {string_reduction(word)}')

print('Example 1:')
solution("aabbccdd")

print('\nExample 2:')
solution("abccba")

print('\nExample 3:')
solution("abcdef")

print('\nExample 4:')
solution("aabbaeaccdd")

print('\nExample 5:')
solution("mississippi")
