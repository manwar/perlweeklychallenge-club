#!/usr/bin/env python

import re

def nums(n):
  nums = []
  for i in range(2 ** n):
    fmt = '{:0' + str(n) + 'b}'
    nums.append(fmt.format(i))
  return nums

def replace_question_mark(string):
  # how many question marks
  marks = len([ c for c in string if c == '?' ])
  # trivial case: no question marks
  if marks == 0: return [string]
  # produce all the combinations
  output = []
  for bits in nums(marks):
    b = [ c for c in bits ]
    output.append(re.sub(r'\?', lambda m: b.pop(0), string))
  return output

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(string):
  print(f'Input: $str = "{string}"')
  output = replace_question_mark(string)
  print(f'Output: ({quote_join(output)})')

print('Example 1:')
solution("01??0")

print('\nExample 2:')
solution("101")

print('\nExample 3:')
solution("???")

print('\nExample 4:')
solution("1?10")

print('\nExample 5:')
solution("1?1?0")
