#!/usr/bin/env python

def displayTwo(display1, display2):
  display = []
  # split the two strings and join each row together
  for d1,d2 in zip(display1.split("\n"), display2.split("\n")):
    display.append(d1 + d2)
  return "\n".join(display)

def displayMatrix(label, matrix):
  width = (len(matrix[0]) + 2) * 2 + 1
  display = label.ljust(width) + "\n"
  for r in range(len(matrix)):
    display += "[ " + int_join(" ",matrix[r]) + " ]  \n"
  return display

def emptyMatrix(row, col):
  matrix = []
  for r in range(row):
    matrix.append([])
    for c in range(col):
      matrix[r].append(0)
  return matrix

def incrementRow(row, matrix):
  for col in range(len(matrix[0])):
    matrix[row][col] += 1
  return matrix

def incrementCol(col, matrix):
  for row in range(len(matrix)):
    matrix[row][col] += 1
  return matrix

def countOdd(matrix):
  count = 0
  for row in range(len(matrix)):
    for col in range(len(matrix[0])):
      if matrix[row][col] % 2: count += 1
  return count

def odd_matrix(row, col, locations):
  matrix = emptyMatrix(row, col)
  display = displayMatrix("Initial:", matrix)
  for row,col in locations:
    display += f"\nApply [{row},{col}]:\n"

    display += f"Increment row {row}:\n"
    before = displayMatrix("Before", matrix)
    matrix = incrementRow(row, matrix)
    after = displayMatrix("After", matrix)
    display += displayTwo(before, after)

    display += f"Increment col {col}:\n"
    before = displayMatrix("Before", matrix)
    matrix = incrementCol(col, matrix)
    after = displayMatrix("After", matrix)
    display += displayTwo(before, after)
  display += "\n"
  return(
    countOdd(matrix),
    display + displayMatrix('Final:', matrix)
  )

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(row, col, locations):
  loc_list = ",".join([
    f"[{int_join(',', x)}]" for x in locations
  ])
  print(
    f'Input: $row = {row}, $col = {col}, ' +
    f'@locations = ({loc_list})'
  )
  odd, explain = odd_matrix(row, col, locations)
  print(f'Output: {odd}\n\n{explain}')


print('Example 1:')
solution(2, 3, [[0,1],[1,1]])

print('\nExample 2:')
solution(2, 2, [[1,1],[0,0]])

print('\nExample 3:')
solution(3, 3, [[0,0],[1,2],[2,1]])

print('\nExample 4:')
solution(1, 5, [[0,2],[0,4]])

print('\nExample 5:')
solution(4, 2, [[1,0],[3,1],[2,0],[0,1]])
