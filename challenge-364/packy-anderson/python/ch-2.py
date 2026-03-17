#!/usr/bin/env python

import re

al_re = re.compile(r'\(al\)')
o_re  = re.compile(r'\(\)')

def parser(string):
  string = al_re.sub("al", string)
  return o_re.sub("o", string)

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{parser(string)}"')

print('Example 1:')
solution("G()(al)")

print('\nExample 2:')
solution("G()()()()(al)")

print('\nExample 3:')
solution("(al)G(al)()()")

print('\nExample 4:')
solution("()G()G")

print('\nExample 5:')
solution("(al)(al)G()()")
