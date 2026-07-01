#!/usr/bin/env python

from collections import Counter

def sum_frequencies(string):
  vowels     = Counter([ c for c in string if c     in "aeiou" ])
  consonants = Counter([ c for c in string if c not in "aeiou" ])
  vowels[0]     = 0 # if there weren't any counted,
  consonants[0] = 0 # set the count to 0
  return (
    vowels.most_common(1)[0][1] + consonants.most_common(1)[0][1]
  )

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {sum_frequencies(string)}')

print('Example 1:')
solution("banana")

print('\nExample 2:')
solution("teestett")

print('\nExample 3:')
solution("aeiouuaa")

print('\nExample 4:')
solution("rhythm")

print('\nExample 5:')
solution("x")
