#!/usr/bin/env python

from collections import Counter

def uniqueOccurrences(ints):
  counts = Counter()
  for i in ints:
    # count how many time each int occurs
    counts[i] += 1
  seen = {}
  for i, c in counts.items():
    # if we've seen this count before, return 0
    if c in seen: return 0
    seen[c] = i
  # each count was unique
  return 1

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  print(f'Output: {uniqueOccurrences(ints)}')

print('Example 1:')
solution([1,2,2,1,1,3])

print('\nExample 2:')
solution([1,2,3])

print('\nExample 3:')
solution([-2,0,1,-2,1,1,0,1,-2,9])
