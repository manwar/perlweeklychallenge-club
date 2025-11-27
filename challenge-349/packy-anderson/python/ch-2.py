#!/usr/bin/env python

def meeting_point(path):
  x, y = 0, 0
  for step in path:
    match step:
      case "U": y += 1
      case "D": y -= 1
      case "R": x += 1
      case "L": x -= 1
    if (x, y) == (0, 0): return True
  return False

def solution(path):
  print(f'Input: $path = "{path}"')
  print(f'Output: {meeting_point(path)}')

print('Example 1:')
solution("ULD")

print('\nExample 2:')
solution("ULDR")

print('\nExample 3:')
solution("UUURRRDDD")

print('\nExample 4:')
solution("UURRRDDLLL")

print('\nExample 5:')
solution("RRUULLDDRRUU")
