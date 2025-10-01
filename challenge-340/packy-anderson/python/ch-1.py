#!/usr/bin/env python

import re

def duplicate_removal(strval):
  m = re.search(r'([a-z])\1', strval)
  if not m: return strval
  return duplicate_removal(
    strval.replace(m.group(0), '', count=1)
  )

def solution(strval):
  print(f"Input: $str = '{strval}'")
  print(f"Output: '{duplicate_removal(strval)}'")

print('Example 1:')
solution("abbaca")

print('\nExample 2:')
solution("azxxzy")

print('\nExample 3:')
solution("aaaaaaaa")

print('\nExample 4:')
solution("aabccba")

print('\nExample 5:')
solution("abcddcba")
