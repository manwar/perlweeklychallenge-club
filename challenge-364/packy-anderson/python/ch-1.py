#!/usr/bin/env python

import re

jz_re = re.compile(r'(\d\d)(\#)')
ai_re = re.compile(r'(\d)')

def to_char(match):
  return chr( int(match.group(1)) + 96 )

def derypt(string):
  string = jz_re.sub(to_char, string)
  return ai_re.sub(to_char, string)

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{derypt(string)}"')

print('Example 1:')
solution("10#11#12")

print('\nExample 2:')
solution("1326#")

print('\nExample 3:')
solution("25#24#123")

print('\nExample 4:')
solution("20#5")

print('\nExample 5:')
solution("1910#26#")
