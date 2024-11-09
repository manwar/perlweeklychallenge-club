#!/usr/bin/env python

from collections import Counter

def consecutiveSequence(ints):
  count  = Counter(ints) # count the values
  maxVal = max(ints) # find the max value
  maxSeq = 1
  seq = 0
  for i in range(maxVal + 1): # because range(n) goes from 0 to n-1
    if (count[i] > 0):
      seq += 1 # we've found a consecutive value
      if seq > maxSeq:
        maxSeq = seq # keep track of the longest
    else:
      seq = 0 # the sequence broke

  # we want sequences longer than one value
  return maxSeq if maxSeq > 1 else -1

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  print(f'Output: { consecutiveSequence(ints) }')

print('Example 1:')
solution([10, 4, 20, 1, 3, 2])

print('\nExample 2:')
solution([0, 6, 1, 8, 5, 2, 4, 3, 0, 7])

print('\nExample 3:')
solution([10, 30, 20])
