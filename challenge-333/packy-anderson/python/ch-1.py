#!/usr/bin/env python

def straightLine(point_list):
  a = point_list.pop(0)
  b = point_list.pop(0)
  c = point_list.pop(0)
  return (
    (a[0] - b[0]) * (b[1] - c[1])
    ==
    (b[0] - c[0]) * (a[1] - b[1])
  )

def solution(point_list):
  str_list = ", ".join([ f"[{p[0]}, {p[1]}]" for p in point_list ])
  print(f'Input: @lists = ({str_list})')
  print(f'Output: {straightLine(point_list)}')


print('Example 1:')
solution([[2, 1], [2, 3], [2, 5]])

print('\nExample 2:')
solution([[1, 4], [3, 4], [10, 4]])

print('\nExample 3:')
solution([[0, 0], [1, 1], [2, 3]])

print('\nExample 4:')
solution([[1, 1], [1, 1], [1, 1]])

print('\nExample 5:')
solution([[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]])