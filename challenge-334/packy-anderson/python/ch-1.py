#!/usr/bin/env python

def range_sum(ints, x, y):
  return sum(ints[x:y+1])

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints, x, y):
  print(
    f'Input: @ints = ({int_join(", ", ints)}), ' +
    f'$x = {x}, $y = {y}'
  )
  print(f'Output: {range_sum(ints, x, y)}')


print('Example 1:')
solution([-2, 0, 3, -5, 2, -1], 0, 2)

print('\nExample 2:')
solution([1, -2, 3, -4, 5], 1, 3)

print('\nExample 3:')
solution([1, 0, 2, -1, 3], 3, 4)

print('\nExample 4:')
solution([-5, 4, -3, 2, -1, 0], 0, 3)

print('\nExample 5:')
solution([-1, 0, 2, -3, -2, 1], 0, 2)
