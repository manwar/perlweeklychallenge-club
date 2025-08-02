#!/usr/bin/env python

def sortByHammingWeight(ints):
  # use Decorate-Sort-Undecorate idiom
  # (yes, it's a Schwartzian Transformation)
  decorated = [ ( i.bit_count(), i ) for i in ints ]
  decorated.sort()
  return [ i for (bits, i) in decorated ]

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    out = sortByHammingWeight(ints)
    print(f'Output: ({comma_join(out)})')

print('Example 1:')
solution([0, 1, 2, 3, 4, 5, 6, 7, 8])

print('\nExample 2:')
solution([1024, 512, 256, 128, 64])