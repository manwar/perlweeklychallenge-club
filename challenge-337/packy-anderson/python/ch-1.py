#!/usr/bin/env python

from collections import Counter

def smaller_than(num1):
  bag = Counter(num1)
  out = []
  for i in range(len(num1)):
    out.append(
      sum(bag[key] for key in bag.keys() if key <= num1[i]) - 1
    )
  return out

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(num1):
  print(f'Input: @num1 = ({int_join(", ", num1)})')
  out = smaller_than(num1)
  print(f'Output: ({int_join(", ", out)})')


print('Example 1:')
solution([6, 5, 4, 8])

print('\nExample 2:')
solution([7, 7, 7, 7])

print('\nExample 3:')
solution([5, 4, 3, 2, 1])

print('\nExample 4:')
solution([-1, 0, 3, -2, 1])

print('\nExample 5:')
solution([0, 1, 1, 2, 0])
