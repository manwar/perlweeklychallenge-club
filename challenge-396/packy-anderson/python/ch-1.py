#!/usr/bin/env python

def finishing_order(order, friends):
  return [ f for f in order if f in friends ]

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(order, friends):
  print(f'Input: @order   = ({int_join(", ", order)})')
  print(f'       @friends = ({int_join(", ", friends)})')
  print(f'Output: ({int_join(", ", finishing_order(order, friends))})')

print('Example 1:')
solution([3, 1, 4, 2, 5],[1, 2, 4])

print('\nExample 2:')
solution([5, 4, 3, 2, 1],[1, 3, 5])

print('\nExample 3:')
solution([2, 4, 1, 3],[1, 2, 3, 4])

print('\nExample 4:')
solution([4, 1, 3, 2],[3])

print('\nExample 5:')
solution([1, 3, 2, 6, 5, 4],[1, 2, 3])
