#!/usr/bin/env python

import re
from collections import defaultdict

has_repeating = re.compile(r"(.).*\1")

def largest_interval(intval):
  integers = [
    i for i in range(1, intval+1)
      if not has_repeating.search(str(i))
  ]
  diffs = defaultdict(list)
  for i in range(2, len(integers)):
    prev, cur = integers[i-1], integers[i]
    d = cur - prev
    diffs[d].append(f'{prev} and {cur}')
  largest = max(diffs.keys())
  return largest, diffs[largest]

def solution(intval):
  print(f'Input: $int = {intval}')
  interval, list_jumps = largest_interval(intval)
  print(f'Output: {interval}\n\nBiggest jump between:')
  print(f' • ' + "\n • ".join(list_jumps))

print('Example 1')
solution(20)

print('\nExample 2')
solution(110)

print('\nExample 3')
solution(500)

print('\nExample 4')
solution(2026)

print('\nExample 5')
solution(10000)
