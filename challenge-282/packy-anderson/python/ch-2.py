#!/usr/bin/env python

def keyChanges(strVal):
  chars = list(strVal)
  char  = chars.pop(0)
  changes = 0
  for next in chars:
    if char.lower() != next.lower():
      changes += 1
    char = next
  return changes

def solution(strVal):
  print(f"Input: $str = '{strVal}'")
  print(f"Output: {keyChanges(strVal)}")

print('Example 1:')
solution("pPeERrLl")

print('\nExample 2:')
solution("rRr")

print('\nExample 3:')
solution("GoO")
