#!/usr/bin/env python

from collections import Counter

def manhattan_distance(a, b):
  return (
    abs(a[0] - b[0]) + abs(a[1] - b[1]),
    f'|{a[0]} - {b[0]}| + |{a[1]} - {b[1]}|'
  )

def format_point(p):
  return f'[{p[0]}, {p[1]}]'

def nvp(x, y, points):
  explanation = ''

  # find the "valid" points
  valid = Counter()
  for i in range(len(points)):
    if points[i][0] == x or points[i][1] == y:
      valid[i] = 1
  if len(valid) == 0:
    return (-1, f'No point shares x or y with ({x}, {y}).')

  if (len(valid) == len(points)):
    explanation = 'Valid points: all of them'
  else:
    vpoints = [ format_point(points[i]) for i in valid.keys() ]
    explanation = 'Valid points: ' + ', '.join(vpoints)

  # now find the distances from the valid points to (x,y)
  explanation += '\n\nManhattan distances:\n'
  dist = {}
  for i in range(len(points)):
    if valid[i]:
      d, e = manhattan_distance([x, y], points[i]) 
      explanation += (
        "    " + format_point(points[i]) + f' => {e} => {d}\n'
      )
      # add the index to a list for this distance
      # get the existing list in d, default to empty list
      l = dist.setdefault(d, [])
      l.append(i)

  # the minimum key in the dist dict is the minimum distance
  min_val = min(dist.keys())

  # pick the lowest index from the min distance array
  i = dist[min_val][0]

  if len(dist[min_val]) == 1:  # only one min distance
    explanation += (
      '\nClosest valid point is ' + format_point(points[i]) +
      f' at index {i}.'
    )
  elif len(dist[min_val]) < len(valid):
    tie_list = [ str(n) for n in dist[min_val] ]
    explanation += (
      '\nTie between index ' + ' and '.join(tie_list) +
      f', pick the smaller index: {i}.'
    )
  else:
    explanation += (
      f'\nAll tie, return the one with the lowest index: {i}.'
    )

  return (i, explanation)

def solution(x, y, points):
  str_list = ', '.join([format_point(p) for p in points])
  print(f'Input: $x = {x}, $y = {y}, @points ({str_list})')
  output, explain = nvp(x, y, points)
  print(f'Output: {output}\n\n{explain}')

print('Example 1:')
solution(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]])

print('\nExample 2:')
solution(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]])

print('\nExample 3:')
solution(1, 1, [[2, 2], [3, 3], [4, 4]])

print('\nExample 4:')
solution(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]])

print('\nExample 5:')
solution(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]])
