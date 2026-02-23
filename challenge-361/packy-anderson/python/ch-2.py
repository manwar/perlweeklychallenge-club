#!/usr/bin/env python

def celebrity(party):
  n = len(party)
  knows    = [0] * n # init all elements to 0
  known_by = [0] * n
  for i in range(n):
    for j in range(n):
      knows[i]    += party[i][j]
      known_by[j] += party[i][j]
  for i in range(n):
    if knows[i] == 0 and known_by[i] == n-1:
      return i
  return -1

def formatMatrix(matrix, indent=16):
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

def solution(party):
  print(f'Input: @party = {formatMatrix(party)}')
  print(f'Output: {celebrity(party)}')

print('Example 1:')
solution([
  [0, 0, 0, 0, 1, 0],  # 0 knows 4
  [0, 0, 0, 0, 1, 0],  # 1 knows 4
  [0, 0, 0, 0, 1, 0],  # 2 knows 4
  [0, 0, 0, 0, 1, 0],  # 3 knows 4
  [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
  [0, 0, 0, 0, 1, 0],  # 5 knows 4
])

print('\nExample 2:')
solution([
  [0, 1, 0, 0],  # 0 knows 1
  [0, 0, 1, 0],  # 1 knows 2
  [0, 0, 0, 1],  # 2 knows 3
  [1, 0, 0, 0]   # 3 knows 0
])

print('\nExample 3:')
solution([
  [0, 0, 0, 0, 0],  # 0 knows NOBODY
  [1, 0, 0, 0, 0],  # 1 knows 0
  [1, 0, 0, 0, 0],  # 2 knows 0
  [1, 0, 0, 0, 0],  # 3 knows 0
  [1, 0, 0, 0, 0]   # 4 knows 0
])

print('\nExample 4:')
solution([
  [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
  [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
  [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
  [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
  [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
  [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
])

print('\nExample 5:')
solution([
  [0, 1, 1, 0],  # 0 knows 1 and 2
  [1, 0, 1, 0],  # 1 knows 0 and 2
  [0, 0, 0, 0],  # 2 knows NOBODY
  [0, 0, 0, 0]   # 3 knows NOBODY
])

print('\nExample 6:')
solution([
  [0, 0, 1, 1],  # 0 knows 2 and 3
  [1, 0, 0, 0],  # 1 knows 0
  [1, 1, 0, 1],  # 2 knows 0, 1 and 3
  [1, 1, 0, 0]   # 3 knows 0 and 1
])
