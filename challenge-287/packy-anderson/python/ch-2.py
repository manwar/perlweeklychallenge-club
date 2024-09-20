#!/usr/bin/env python

import re

sign = r'[+\-]'

digits = r'\d+'

integerNumber = fr' {sign}? {digits} '

decimalNumber = fr"""
  {sign}? (?: {digits}\. | {digits}\.{digits} | \.{digits} )
"""

exponent = fr'(?:[eE]{integerNumber})'

TOP = re.compile(fr"""
  ^ (?:
      {integerNumber}{exponent}? |
      {decimalNumber}{exponent}?
    ) $
  """,
  re.VERBOSE
)

def solution(str):
    print(f'Input: $str = "{str}"')
    match = True if re.search(TOP, str) else False
    print(f'Output: {match}')

print('Example 1:')
solution("1")

print('\nExample 2:')
solution("a")

print('\nExample 3:')
solution(".")

print('\nExample 4:')
solution("1.2e4.2")

print('\nExample 5:')
solution("-1.")

print('\nExample 6:')
solution("+1E-8")

print('\nExample 7:')
solution(".44")

print('\nExample 8:')
solution("-३.१")
