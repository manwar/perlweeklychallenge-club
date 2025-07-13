#!/usr/bin/env python

import regex

def counterIntegers(strVar):
  # replace all lower case letters with space
  strVar = regex.sub(r'\p{Lowercase_Letter}+', ' ', strVar)

  # get rid of leading and trailing whitespace
  strVar = strVar.strip()

  # split on whitespace
  parts = strVar.split()

  # build return array of distinct values 
  output = []
  seen = []
  for i in parts:
    if i not in seen:
      output.append(i)
    seen.append(i)

  return output

def solution(strVar):
  print(f'Input: $str = "{strVar}"')
  print(f'Output: {", ".join(counterIntegers(strVar))}')

print('Example 1:')
solution("the1weekly2challenge2")

print('\nExample 2:')
solution("go21od1lu5c7k")

print('\nExample 3:')
solution("4p3e2r1l")
