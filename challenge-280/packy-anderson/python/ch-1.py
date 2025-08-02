#!/usr/bin/env python

from collections import Counter

def twiceAppearance(str):
  count = Counter()
  for char in str:
    count[char] += 1
    if count[char] > 1:
       return char
  return "␀" # fallback

def solution(str):
    print(f'Input: $str = "{str}"')
    print(f'Output: "{twiceAppearance(str)}"')

print('Example 1:')
solution("acbddbca")

print('\nExample 2:')
solution("abccd")

print('\nExample 3:')
solution("abcdabbb")

print('\nExample 4:')
solution("abcdefg")
