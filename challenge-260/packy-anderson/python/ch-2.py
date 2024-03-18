#!/usr/bin/env python

from itertools import permutations

def dictionaryRank(word):
  # we don't need to split the string, because
  # permutations() will accept a string as a parameter
  #
  # set() produces a set of unique elements
  #
  # sorted() returns a sorted list
  perms = sorted(
    set([ ''.join(l) for l in permutations(word) ])
  )
  rank = 1
  for p in perms:
    if p == word: return rank
    rank += 1

def solution(word):
  print(f"Input: $word = '{word}'")
  print(f'Output: {dictionaryRank(word)}')

print('Example 1:')
solution('CAT')

print('\nExample 2:')
solution('GOOGLE')

print('\nExample 3:')
solution('SECRET')
