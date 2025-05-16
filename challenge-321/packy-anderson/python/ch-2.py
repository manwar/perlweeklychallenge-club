#!/usr/bin/env python

import re

def backspaceCompare(str1, str2):
  s1 = re.sub(r'.\#', "", str1)
  while s1 != str1:
    str1 = s1
    s1 = re.sub(r'.\#', "", str1)
  s2 = re.sub(r'.\#', "", str2)
  while s2 != str2:
    str2 = s2
    s2 = re.sub(r'.\#', "", str2)
  return s1 == s2

def solution(str1, str2):
  print(f'Input: $str1 = "{str1}"')
  print(f'       $str2 = "{str2}"')
  print(f'Output: { backspaceCompare(str1, str2) }')

print('Example 1:')
solution("ab#c", "ad#c")

print('\nExample 2:')
solution("ab##", "a#b#")

print('\nExample 3:')
solution("a#b", "c")
