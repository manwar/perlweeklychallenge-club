#!/usr/bin/env python

from collections import Counter

def odd_letters(str_val):
  for k,v in Counter(list(str_val)).items():
    if v % 2 == 0: return 'false'
  return 'true'

def solution(str_val):
  print(f'Input: $str = "{str_val}"')
  print(f'Output: {odd_letters(str_val)}')

print('Example 1:')
solution("weekly")

print('\nExample 2:')
solution("perl")

print('\nExample 3:')
solution("challenge")
