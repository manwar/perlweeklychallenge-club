#!/usr/bin/env python

import re

def decode_string(string):
  while match := re.search(r'((\d+)\[([^\[\]]+)\])', string):
    r = match.group(3) * int(match.group(2))
    string = string.replace(match.group(1), r)
  return string

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{decode_string(string)}"')

print('Example 1:')
solution("2[3[a]]")

print('\nExample 2:')
solution("10[a]")

print('\nExample 3:')
solution("a2[b]c3[d]e")

print('\nExample 4:')
solution("2[a2[b]c]")

print('\nExample 5:')
solution("1[a]2[b3[c]]")
