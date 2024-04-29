#!/usr/bin/env python

def isDiagonal(x, y, N):
  return (
    N == 1 or N == 2 or x == y or x + y == N - 1
  )

def isXMatrix(matrix):
  N = len(matrix)
  for y, row in enumerate(matrix):
    for x, value in enumerate(row):
      # fail if diagonal values are zero or
      # non-diagonal values are non-zero
      if isDiagonal(x, y, N) != (value != 0):
        return False
  return True

def formatMatrix(matrix, indent=17):
    output = []
    for row in matrix:
        output_row = ' ' * indent + '  ['
        output_row += ', '.join(map(lambda i: str(i), row))
        output_row += ']'
        output.append(output_row)

    return(
        "[\n" + ",\n".join(output) + "\n" +
        ' ' * indent + ']'
    )

def solution(matrix):
    print(f'Input: $matrix = {formatMatrix(matrix)}')
    print(f'Output: {isXMatrix(matrix)}')

print('Example 1:')
solution([
  [1, 0, 0, 2],
  [0, 3, 4, 0],
  [0, 5, 6, 0],
  [7, 0, 0, 1],
])

print('\nExample 2:')
solution([
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
])

print('\nExample 3:')
solution([
  [1, 0, 2],
  [0, 3, 0],
  [4, 0, 5],
])

print('\nExample 4:')
solution([
  [1, 0, 0, 0, 1],
  [0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
])

print('\nExample 5:')
solution([
  [1, 0, 1, 0, 1],
  [0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
])

print('\nExample 6:')
solution([
  [1, 1],
  [1, 1]
])

print('\nExample 7:')
solution([
  [1, 0],
  [1, 1]
])
