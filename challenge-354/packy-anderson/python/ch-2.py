#!/usr/bin/env python

def shift_grid(matrix, k):
  # get the dimensions of the matrix
  m, n = len(matrix), len(matrix[0])

  # flatten the matrix
  flat = sum(matrix, [])

  while k > 0:
    flat.insert(0, flat.pop()) # shift to the right
    k -= 1

  # re-matrix the array
  result = []
  while m > 0:
    result.append(flat[0:n])
    del flat[0:n]
    m -= 1

  return result

def format_matrix(matrix, indent=19):
  output = []
  spacer = ",\n" + (' ' * indent)
  for row in matrix:
    output.append(
      "[" + ", ".join(map(str, row)) + "]"
    )
  return('[ ' + spacer.join(output) + ' ]')

def solution(matrix, k):
  print(f'Input: @matrix = {format_matrix(matrix)}')
  print(f'       $k = {k}')
  output = shift_grid(matrix, k)
  print(f'Output: {format_matrix(output, 10)}')

print('Example 1:')
solution([[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]], 1)

print('\nExample 2:')
solution([[10, 20],
          [30, 40]], 1)

print('\nExample 3:')
solution([[1, 2],
          [3, 4],
          [5, 6]], 1)

print('\nExample 4:')
solution([[1, 2, 3],
          [4, 5, 6]], 5)

print('\nExample 5:')
solution([[1, 2, 3, 4]], 1)
