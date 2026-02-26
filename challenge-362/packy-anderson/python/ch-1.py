#!/usr/bin/env python

def echo(string):
  i = 1
  result = ""
  for c in string:
    result += c * i
    i += 1
  return result

def solution(string):
  print(f'Input: "{string}"')
  print(f'Output: "{echo(string)}"')

print('Example 1:')
solution("abca")

print('\nExample 2:')
solution("xyz")

print('\nExample 3:')
solution("code")

print('\nExample 4:')
solution("hello")

print('\nExample 5:')
solution("a")
