#!/usr/bin/env python

def has_all_num(n, elems):
  if len(elems) != n: return False # check num of elems
  for i in range(1, n+1):
    if i not in elems: return False
  return True

def same_row_column(matrix):
  n = len(matrix)
  for row in matrix: # check the row
    if not has_all_num(n, row): return False
  for col in zip(*matrix): # check columns
    if not has_all_num(n, col): return False
  return True

def format_matrix(matrix, indent=17):
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
  print(f'Input: @matrix = {format_matrix(matrix)}')
  print(f'Output: {same_row_column(matrix)}')

print('Example 1:')
solution([
  [1, 2, 3, 4],
  [2, 3, 4, 1],
  [3, 4, 1, 2],
  [4, 1, 2, 3]
])

print('\nExample 2:')
solution([[1],])

print('\nExample 3:')
solution([
  [1, 2, 5],
  [5, 1, 2],
  [2, 5, 1]
])

print('\nExample 4:')
solution([
  [1, 2, 3],
  [1, 2, 3],
  [1, 2, 3] 
])

print('\nExample 5:')
solution([
  [1, 2, 3],
  [3, 1, 2],
  [3, 2, 1]
])
