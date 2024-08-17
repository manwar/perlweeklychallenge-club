#!/usr/bin/env python

def goodInteger(intVal):
  chars = list(str(intVal))
  good  = chars.pop(0)
  count = 1
  for c in chars:
    if c != good:
      # the character changed!
      if count == 3:
        break
      # restart the count with new character
      good  = c
      count = 1
    else:
      # the character is the same
      count += 1
  if count == 3:
    return '"' + (good * count) + '"'
  return -1

def solution(intVal):
  print(f'Input: $int = ({intVal})')
  print(f'Output: {goodInteger(intVal)}')

print('Example 1:')
solution(12344456)

print('\nExample 2:')
solution(1233334)

print('\nExample 3:')
solution(10020003)
