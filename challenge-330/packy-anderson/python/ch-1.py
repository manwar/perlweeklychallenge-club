#!/usr/bin/env python

import re
cd = re.compile(r'\D\d')

def clear_digits(strVal):
  if cd.search(strVal):
    strVal = clear_digits(cd.sub("", strVal))
  return strVal

def solution(strVal):
  print(f'Input: $str = "{strVal}"')
  print(f'Output: "{clear_digits(strVal)}"')

print('Example 1:')
solution("cab12")

print('\nExample 2:')
solution("xy99")

print('\nExample 3:')
solution("pa1erl")
