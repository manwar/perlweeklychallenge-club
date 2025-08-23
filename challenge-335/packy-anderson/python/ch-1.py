#!/usr/bin/env python

from collections import Counter

def common_characters(words):
  # make multisets of the words' characters
  bags = [ Counter(list(w)) for w in words ]
  # make a list of sets of the keys in each bag
  sets = [ set(b.keys()) for b in bags ]
  # convert the keys to sets so we can find the intersection
  keys = set.intersection(*sets)
  common = []
  for key in keys:
    # get the lowest count for the key from each bag
    lowest = min([ b[key] for b in bags ])
    # insert that many of the key into the common array
    for i in range(lowest): common.append(key)
  return sorted(common)

def quoted_list(arr):
  return ', '.join([ f'"{e}"' for e in arr ])

def solution(words):
  print(f'Input: @nums = ({quoted_list(words)})')
  common = common_characters(words)
  print(f'Output: ({quoted_list(common)})')


print('Example 1:')
solution(["bella", "label", "roller"])

print('\nExample 2:')
solution(["cool", "lock", "cook"])

print('\nExample 3:')
solution(["hello", "world", "pole"])

print('\nExample 4:')
solution(["abc", "def", "ghi"])

print('\nExample 5:')
solution(["aab", "aac", "aaa"])