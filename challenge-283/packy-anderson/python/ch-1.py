#!/usr/bin/env python

from collections import Counter

def uniqueNumber(ints):
  bag = Counter(ints)  # count occurrences
  keys = [
    k                      # return just the keys
    for k,v in bag.items() # get key/value pairs
    if v == 1              # keys that occur once
  ]

  # invalid input
  if len(keys) == 0:
    return 'no element appears only once'
  if len(keys) > 1:
    return 'multiple elements appear only once'

  # return the one value
  return keys.pop(0)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    print(f'Output: {uniqueNumber(ints)}')

print('Example 1:')
solution([3, 3, 1])

print('\nExample 2:')
solution([3, 2, 4, 2, 4])

print('\nExample 3:')
solution([1])

print('\nExample 4:')
solution([4, 3, 1, 1, 1, 4])

print('\nInvalid Input 1 (no element appears only once):')
solution([4, 1, 1, 1, 4])

print('\nInvalid Input 2 (multiple elements appear only once):')
solution([1, 2, 3, 4])
