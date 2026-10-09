#!/usr/bin/env python

import re

is_alternating = re.compile('^(?:[a-z]?(?:[A-Z][a-z])+|' +
                            '[A-Z]?(?:[a-z][A-Z])+)$')

def no_alt(s, i):
  noalt = ('([A-Z]{'+str(i)+'}[a-z]{'+str(i)+'}|' +
            '[a-z]{'+str(i)+'}[A-Z]{'+str(i)+'})')
  noalt = re.compile(noalt)
  return noalt.search(s)

def alternate_case(s):
  if is_alternating.match(s): return 0, []
  swaps = []
  while True:
    i = len(s) // 2
    for j in range(i, 0, -1):
      m = no_alt(s, j)
      if m:
        start = m.start() + (len(m.group()) // 2) - 1
        flip = s[start:start+2][::-1]
        s = s[:start] + flip + s[start+2:]
        swaps.append(s)
        break
    if is_alternating.match(s): return len(swaps), swaps

def solution(s):
  print(f'Input: $str = "{s}"')
  count, swaps = alternate_case(s)
  print(f'Output: {count}')
  if swaps:
    print()
    for c in range(len(swaps)):
      print(f'Swap {c+1}: "{swaps[c]}"')

print('Example 1:')
solution("aAbB")

print('\nExample 2:')
solution("AAbb")

print('\nExample 3:')
solution("AAAbbb")

print('\nExample 4:')
solution("aABb")

print('\nExample 5:')
solution("bBBAaa")
