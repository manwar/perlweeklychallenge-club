#!/usr/bin/env python

import re

def bigger(string, char):
  indices = [ m.start() for m in re.finditer(char, string) ]
  if not indices: return string # doesn't occur
  return max([
    string[0:i]+string[i+1:] for i in indices
  ])


def solution(string, char):
  print(f'Input: $str = "{string}", $char = "{char}"')
  print(f'Output: "{bigger(string, char)}"')

print('Example 1:')
solution("15456", "5")

print('\nExample 2:')
solution("7332", "3")

print('\nExample 3:')
solution("2231", "2")

print('\nExample 4:')
solution("543251", "5")

print('\nExample 5:')
solution("1921", "1")

print('\nExample trivial 1:')
solution("12345", "6")

print('\nExample trivial 2:')
solution("12345", "1")
