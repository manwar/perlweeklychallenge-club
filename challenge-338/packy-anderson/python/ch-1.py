#!/usr/bin/env python

def highest_row(matrix):
  return max( [ sum(row) for row in matrix ] )

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(matrix):
  m = ",\n                  ".join(
    [ "[" + int_join(", ", row) + "]" for row in matrix ]
  )
  print(f'Input: @matrix = ({m})')
  print(f'Output: {highest_row(matrix)}')


print('Example 1:')
solution([[4,  4, 4, 4],
          [10, 0, 0, 0],
          [2,  2, 2, 9]])

print('\nExample 2:')
solution([[1, 5],
          [7, 3],
          [3, 5]])

print('\nExample 3:')
solution([[1, 2, 3],
          [3, 2, 1]])

print('\nExample 4:')
solution([[2, 8, 7],
          [7, 1, 3],
          [1, 9, 5]])

print('\nExample 5:')
solution([[10, 20,  30],
          [5,  5,   5],
          [0,  100, 0],
          [25, 25,  25]])
