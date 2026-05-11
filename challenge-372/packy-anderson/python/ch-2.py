#!/usr/bin/env python

from collections import Counter
import re

def largest(string):
  maxval = 0
  explain = []
  for c,v in Counter([ c for c in string ]).items():
    if v <= 1: continue # filter out single chars
    pattern = re.compile(f'{c}(.*){c}')
    m = pattern.search(string)
    maxval = max(maxval, len(m[1]))
    explain.append(
      f'For character "{c}", we have substring "{m[1]}".'
    )
  return str(maxval) + "\n\n" + "\n".join(explain)

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {largest(string)}')

print('Example 1:')
solution("aaaaa")

print('\nExample 2:')
solution("abcdeba")

print('\nExample 3:')
solution("abbc")

print('\nExample 4:')
solution("abcaacbc")

print('\nExample 5:')
solution("laptop")
