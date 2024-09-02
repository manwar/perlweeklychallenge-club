#!/usr/bin/env python

from collections import Counter

def luckyInteger(ints):
  bag = Counter(ints)  # count occurrences
  keys = [
    k                      # return just the keys
    for k,v in bag.items() # get key/value pairs
    if v == k              # keys that match freq
  ]

  if len(keys) == 0:
    return -1  # return -1 if no lucky int was found

  return sorted(keys).pop(-1) # return the largest lucky int

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    print(f'Output: {luckyInteger(ints)}')

print('Example 1:')
solution([2, 2, 3, 4])

print('\nExample 2:')
solution([1, 2, 2, 3, 3, 3])

print('\nExample 3:')
solution([1, 1, 1, 3])
