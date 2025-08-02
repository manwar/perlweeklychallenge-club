#!/usr/bin/env python

def twoDarray(ints, r, c):
  if (len(ints) != r * c):
    return (
         "Unable to create a two-dimensional array with "
      + f"{r} rows and {c} columns\nfrom a list of {len(ints)} "
      + f"integers; there must be {r * c} integers.",
      []
    )
  arr = []
  while (ints):
    row = []
    for i in range(c):
      row.append( ints.pop(0) )
    arr.append(row)
  return None, arr

def formatMatrix(matrix, indent=8):
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

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(ints, r, c):
  int_list = '(' + int_join(", ", ints) + ')'
  print(f'Input: @ints = {int_list}, $r = {r}, $c = {c}')
  err, arr = twoDarray(ints, r, c)
  if err:
    print(f'\n{err}')
  else:
    print(f'Output: {formatMatrix(arr)}')

print('Example 1:')
solution([1, 2, 3, 4], 2, 2)

print('\nExample 2:')
solution([1, 2, 3], 1, 3)

print('\nExample 3:')
solution([1, 2, 3, 4], 4, 1)

print('\nExample 4:')
solution([1, 2, 3, 4], 3, 1)

print('\nExample 5:')
solution([1, 2, 3, 4], 3, 2)
