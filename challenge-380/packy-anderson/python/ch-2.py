#!/usr/bin/env python

def reversed_pos(char):
  return "zyxwvutsrqponmlkjihgfedcba".index(char) + 1

def reverse_degree(string):
  pos = 1
  sum = 0
  for char in string:
    sum += (reversed_pos(char) * pos)
    pos += 1
  return sum

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {reverse_degree(string)}')

print('Example 1:')
solution("z")

print('\nExample 2:')
solution("a")

print('\nExample 3:')
solution("bbc")

print('\nExample 4:')
solution("racecar")

print('\nExample 5:')
solution("zyx")
