#!/usr/bin/env python

import re

stop_condition = re.compile(r'^1+0+$')

def rearrange_binary_string(string):
  steps = []
  while not stop_condition.match(string):
    string = re.sub(r'01', '10', string)
    steps.append(string)
  return len(steps), steps

def solution(string):
  print(f'Input: $str = "{string}"')
  count, steps = rearrange_binary_string(string)
  print(f'Output: {count}')
  if count:
    print('')
    for i in range(count):
      print(f'Step {i+1}: "{steps[i]}"')

print('Example 1:')
solution("111000")

print('\nExample 2:')
solution("00011")

print('\nExample 3:')
solution("01011")

print('\nExample 4:')
solution("010101")

print('\nExample 5:')
solution("00001")
