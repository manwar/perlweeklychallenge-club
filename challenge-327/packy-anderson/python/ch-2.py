#!/usr/bin/env python

def MAD(ints):
  mad = []
  # let's make the biggest int our starting minimum
  minDiff = max(ints)
  x = ints.pop(0) # get the first value for x
  while ints:
    for y in ints:
      diff = abs(x - y)
      if diff <= minDiff:  # not too big!
        if diff < minDiff: # we found a new min!
          minDiff = diff   # set the new minimum
          mad = []         # clear the old list
        # make sure we put the numbers on the list
        # with the smaller integer first
        mad.append(sorted([x, y]))
    x = ints.pop(0) # get the next value for x
  # and return the list with the pairs sorted as well
  return sorted(mad, key=lambda x: x[0])

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  mad = []
  for x in MAD(ints):
    mad.append(f'{x}')
  print(f'Output: {", ".join(mad)}')


print('Example 1:')
solution([4, 1, 2, 3])

print('\nExample 2:')
solution([1, 3, 7, 11, 15])

print('\nExample 3:')
solution([1, 5, 3, 8])
