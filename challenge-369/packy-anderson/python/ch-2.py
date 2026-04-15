#!/usr/bin/env python

def group_division(string, size, filler):
  while len(string) % size != 0:
    string += filler
  return [
    string[i:i+size] for i in range(0, len(string), size)
  ]

def solution(string, size, filler):
  print(f'Input: $str = "{string}", $size = {size}, $filler = "{filler}"')
  results = ", ".join([ f'"{w}"' for w in group_division(string, size, filler) ])
  print(f'Output: ({results})')

print('Example 1:')
solution("RakuPerl", 4, "*")

print('\nExample 2:')
solution("Python", 5, "0")

print('\nExample 3:')
solution("12345", 3, "x")

print('\nExample 4:')
solution("HelloWorld", 3, "_")

print('\nExample 5:')
solution("AI", 5, "!")
