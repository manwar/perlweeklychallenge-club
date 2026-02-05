#!/usr/bin/env python

def str_val(s):
  return int(s) if s.isdigit() else len(s)

def max_str_val(strings):
  return max(str_val(s) for s in strings)

def solution(strings):
  strlist = ", ".join([ f'"{s}"' for s in strings])
  print(f'Input: @strings = ({strlist})')
  print(f'Output: {max_str_val(strings)}')

print('Example 1:')
solution(["123", "45", "6"])

print('\nExample 2:')
solution(["abc", "de", "fghi"])

print('\nExample 3:')
solution(["0012", "99", "a1b2c"])

print('\nExample 4:')
solution(["x", "10", "xyz", "007"])

print('\nExample 5:')
solution(["hello123", "2026", "perl"])
