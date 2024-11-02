#!/usr/bin/env python

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def isBoomerang(points):
  # check that we have three distinct points
  distinct = {}
  for p in points:
    distinct[ comma_join(p) ] = 1
  if len(list(distinct)) < 3:
    return 'false'

  # is this a straight line on the X axis?
  if points[0][0] == points[1][0] == points[2][0]:
    return 'false'

  # is this a straight line on the Y axis?
  if points[0][1] == points[1][1] == points[2][1]:
    return 'false'

  # find the differences between the X coordinates
  x_diff_1 = points[1][0] - points[0][0]
  x_diff_2 = points[2][0] - points[1][0]

  # find the differences between the Y coordinates
  y_diff_1 = points[1][1] - points[0][1]
  y_diff_2 = points[2][1] - points[1][1]

  # straight line if the diffs are the same
  if x_diff_1 == x_diff_2 and y_diff_1 == y_diff_2:
    return 'false'

  return 'true'

def solution(points):
  p = [ '[' + comma_join(p) + ']' for p in points ]
  print(f'Input: @points = ({comma_join(p)})')
  print(f'Output: { isBoomerang(points) }')

print('Example 1:')
solution([[1, 1], [2, 3], [3,2]])

print('\nExample 2:')
solution([[1, 1], [2, 2], [3, 3]])

print('\nExample 3:')
solution([[1, 1], [1, 2], [2, 3]])

print('\nExample 4:')
solution([[1, 1], [1, 2], [1, 3]])

print('\nExample 5:')
solution([[1, 1], [2, 1], [3, 1]])

print('\nExample 6:')
solution([[0, 0], [2, 3], [4, 5]])