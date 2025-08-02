#!/usr/bin/env python

from itertools import batched, chain

def decompress(ints):
  out = []
  for i, j in batched(ints, 2):
    out.append([j] * i)
  return list(chain.from_iterable(out))

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {decompress(ints)}')


print('Example 1:')
solution([1, 3, 2, 4])

print('\nExample 2:')
solution([1, 1, 2, 2])

print('\nExample 3:')
solution([3, 1, 3, 2])
