#!/usr/bin/env python

from itertools import combinations, permutations

def is_square(words):
  square = [ [ c for c in w] for w in words ]
  length = len(words[0]) # because range() stops before this
  for i in range(length):
    for j in range(i+1, length):
      if square[i][j] != square[j][i]: return False
  return True

def word_square(words):
  for lst in combinations(words, len(words[0])):
    for perm in permutations(lst):
      if is_square(perm): return perm

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(words):
  print(f'Input: @words = ({quote_join(words)})')
  square = word_square(words)
  print(f'Output: ({quote_join(square)})\n')
  for word in square:
    print(f'    { " ".join([ c for c in word ])}')

print('Example 1:')
solution(["MA", "AM", "MY", "ME"])

print('\nExample 2:')
solution(["SUN", "USE", "NET", "SEE", "TEN"])

print('\nExample 3:')
solution(["BOAT", "TEAL", "AREA", "TSAR", "OGRE"])

print('\nExample 4:')
solution(["CARD", "AREA", "REAR", "DART"])

print('\nExample 5:')
solution(["HEART", "TREND", "EMBER", "RESIN", "ABUSE"])
