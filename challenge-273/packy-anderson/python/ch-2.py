#!/usr/bin/env python

def bAfterA(strVal):
  seen_b = False
  for c in strVal:
    if seen_b:
      if c == 'a':
        return False
    elif c == 'b':
      seen_b = True
  return seen_b

def solution(strVal):
    print(f'Input: $str = "{strVal}"')
    print(f'Output: {bAfterA(strVal)}')

print('Example 1:')
solution("aabb")

print('\nExample 2:')
solution("abab")

print('\nExample 3:')
solution("aaa")

print('\nExample 4:')
solution("bbb")
