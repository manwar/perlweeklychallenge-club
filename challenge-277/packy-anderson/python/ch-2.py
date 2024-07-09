#!/usr/bin/env python

def isStrongPair(x, y):
  return( 0 < abs(x - y) < min(x, y) )

def strongPairs(ints):
  strong = []
  ints = set(sorted(ints))
  for x in ints:
    for y in ints:
      if x < y and isStrongPair(x, y):
        strong.append( f'({x}, {y})' )
  return len(strong), ', '.join(strong)

def comma_join(ints):
  return ', '.join(map(lambda i: str(i), ints))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  c, explain = strongPairs(ints)
  print(f'Output: {c}\n\nStrong Pairs: {explain}')

print('Example 1:')
solution([1, 2, 3, 4, 5])

print('\nExample 2:')
solution([5, 7, 1, 7])
