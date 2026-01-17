#!/usr/bin/env python

from functools import cache
import re

@cache
def kolakoski(num):
  if num == 1: return "(1)"
  digit = "1" if (num % 2) == 1 else "2"
  seq   = kolakoski(num - 1)
  chars = re.sub(r'\D', "", seq) # get rid of the parens
  if chars[num - 1:num] == "1":
    seq += f"({digit})" 
  else:
    seq += f"({digit}{digit})"
  return seq

def kolakoski_sequence(num):
  seq   = kolakoski(num)
  chars = (re.sub(r'\D', '', seq))[0:num]
  count = len(re.sub(r'2', '', chars)) # get rid of 2s
  return (count, f"{seq} => {chars}")

def solution(num):
  print(f'Input: $int = {num}')
  count, explain = kolakoski_sequence(num)
  print(f'Output: {count}\n\n{explain}')

print('Example 1:')
solution(4)

print('\nExample 2:')
solution(5)

print('\nExample 3:')
solution(6)

print('\nExample 4:')
solution(7)

print('\nExample 5:')
solution(8)
