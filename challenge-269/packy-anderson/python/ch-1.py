#!/usr/bin/env python

def bitwisePair(ints):
  first = ints.pop(0)

  # if we have no more elements to
  # compare it to, return false
  if len(ints) == 0: return False

  # bitwise OR the first element with
  # each of the remaining elements and
  # check if the result is even
  for next in ints:
    if ((first | next) & 1) == 0: return True 

  # search the remaining list for pairs
  return bitwisePair(ints)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    print(f'Output: {bitwisePair(ints)}')

print('Example 1:')
solution([1, 2, 3, 4, 5])

print('\nExample 2:')
solution([2, 3, 8, 16])

print('\nExample 3:')
solution([1, 2, 5, 7, 9])
