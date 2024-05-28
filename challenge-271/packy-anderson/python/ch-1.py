#!/usr/bin/env python

def maximumOnes(matrix):
  maxCount = -1
  maxRow   = -1
  for rowNum, row in enumerate(matrix):
    count = sum(row)
    if count > maxCount:
      maxCount = count
      maxRow   = rowNum
  # we're displaying rows 1-indexed
  return maxRow + 1

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
    print(f'Output: { maximumOnes(matrix) }')

print('Example 1:')
solution([ [0, 1],
           [1, 0] ])

print('\nExample 2:')
solution([ [0, 0, 0],
           [1, 0, 1] ])

print('\nExample 3:')
solution([ [0, 0],
           [1, 1],
           [0, 0] ])
