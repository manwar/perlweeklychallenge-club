#!/usr/bin/env python

from collections import Counter

def good_string(mystr):
  good = 0
  for i in range(len(mystr)-2):
    substr = mystr[i:i+3]
    bag = Counter(list(substr))
    if not any([x > 1 for x in bag.values()]):
      good += 1
  return good

def solution(mystr):
  print(f'Input: $str = "{mystr}"')
  print(f'Output: {good_string(mystr)}')


print('Example 1:')
solution("abcaefg")

print('\nExample 2:')
solution("xyzzabc")

print('\nExample 3:')
solution("aababc")

print('\nExample 4:')
solution("qwerty")

print('\nExample 5:')
solution("zzzaaa")
