#!/usr/bin/env python

def stronger(i, j, grid):
  if grid[i][j] == 1: return i
  if grid[i][j] == 0: return j

def champion_team(grid):
  best = []
  my_max = 0
  for team in range(len(grid)):
    my_sum = sum(grid[team])
    if my_sum > my_max:
      best = [team]
      my_max = my_sum
    elif my_sum == my_max:
      best.append(team)
  if len(best) == 1:
    return best[0]
  i, j = best
  return stronger(i, j, grid)

def format_matrix(matrix, indent=15):
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

def solution(grid):
  print(f'Input: @grid = {format_matrix(grid)}')
  print(f'Output: {champion_team(grid)}')

print('Example 1:')
solution([
  [0, 1, 1],
  [0, 0, 1],
  [0, 0, 0]
])

print('\nExample 2:')
solution([
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [1, 1, 0, 0],
  [1, 1, 1, 0]
])

print('\nExample 3:')
solution([
  [0, 1, 0, 1],
  [0, 0, 1, 1],
  [1, 0, 0, 0],
  [0, 0, 1, 0]
])

print('\nExample 4:')
solution([
  [0, 1, 1],
  [0, 0, 0],
  [0, 1, 0]
])

print('\nExample 5:')
solution([
  [0, 0, 0, 0, 0],
  [1, 0, 0, 0, 0],
  [1, 1, 0, 1, 1],
  [1, 1, 0, 0, 0],
  [1, 1, 0, 1, 0]
])
