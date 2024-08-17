#!/usr/bin/env python

def sumRow(matrix, i):
  return sum(matrix[i])

def sumCol(matrix, j):
  return sum([ i[j] for i in matrix ])

def specialPositions(matrix):
  special = []
  for i, row in enumerate(matrix):
    for j, value in enumerate(row):
      # not special unless = 1
      if (value == 1 and
          # not special unless only 1 in row
          sumRow(matrix, i) == 1 and
          # not special unless only 1 in column
          sumCol(matrix, j) == 1):
        # it's special!
        special.append( f"({i}, {j})" )
  explain = 'Special position'
  explain += ' is ' if len(special) == 1 else 's are '
  explain += ', '.join(special)
  return len(special), explain

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
    count, explain = specialPositions(matrix)
    print(f'Output: {count}\n\n{explain}')

print('Example 1:')
solution([
  [1,0,0],
  [0,0,1],
  [1,0,0]
])

print('\nExample 2:')
solution([
  [1,0,0],
  [0,1,0],
  [0,0,1]
])