#!/usr/bin/env python

import re

def is_black(c):
  col, row = c[0:1], int(c[1:2])
  if re.match("[aceg]", col) and (row % 2 == 1): return 1
  if re.match("[bdfh]", col) and (row % 2 == 0): return 1
  return 0

def chessboard_squares(c1, c2):
  return 'true' if is_black(c1) == is_black(c2) else 'false'

def solution(c1, c2):
  print(f'Input: $c1 = "{c1}", $c2 = "{c2}"')
  print(f'Output: {chessboard_squares(c1, c2)}')

print('Example 1:')
solution("a7", "f4")

print('\nExample 2:')
solution("c1", "e8")

print('\nExample 3:')
solution("b5", "h2")

print('\nExample 4:')
solution("f3", "h1")

print('\nExample 5:')
solution("a1", "g8")
