#!/usr/bin/env python

import re
from collections import Counter

vowels     = '[aeiou]'
consonants = '[^aeiou]'

is_alternating = re.compile(
  '^(?:' + vowels + '?(?:' + consonants + vowels + ')+|' +
       consonants + '?(?:' + vowels + consonants + ')+)$'
)

def alt_substrings(s):
  substrings = Counter()
  for i in range(len(s)):
    for j in range(len(s), 1, -1):
      sub = s[i:j]
      if is_alternating.match(sub): substrings[sub] = 1
  return substrings

def lcs(arr):
  bag = alt_substrings(arr.pop(0))
  while arr:
    bag = bag & alt_substrings(arr.pop(0))
  if not list(bag): return [] # bail early
  longest = sorted(list(bag), key=len, reverse=True)[0]
  return sorted([ s for s in list(bag) if len(s)==len(longest) ])

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(arr):
  print(f'Input: @arr = ({quote_join(arr)})')
  print(f'Output: ({quote_join(lcs(arr))})')

print('Example 1:')
solution(["relocate", "delocate", "allocate"])

print('\nExample 2:')
solution(["apple", "banana", "cherry"])

print('\nExample 3:')
solution(["navigate", "cavity", "gravity"])

print('\nExample 4:')
solution(["pedalgia", "pedalboard", "pedantic"])

print('\nExample 5:')
solution(["schoolmaster", "schoolhouse", "schooling"])
