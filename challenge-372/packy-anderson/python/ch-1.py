#!/usr/bin/env python

import re

def rearrange(string):
  words  = string.split()
  spaces = len(re.sub(r'\S+', '', string))
  w = len(words) - 1
  if w == 0:
    return words[0] + (' ' * spaces)
  else:
    between, end = divmod(spaces, w)
    return (' ' * between).join(words) + (' ' * end)

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{rearrange(string)}"')

print('Example 1:')
solution("  challenge  ")

print('\nExample 2:')
solution("coding  is  fun")

print('\nExample 3:')
solution("a b c  d")

print('\nExample 4:')
solution("  team      pwc  ")

print('\nExample 5:')
solution("   the  weekly  challenge  ")
