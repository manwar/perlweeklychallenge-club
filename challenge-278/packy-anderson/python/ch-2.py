#!/usr/bin/env python

def reverseWord(str, char):
  pos = str.find(char)

  # if the character isn't in the string, do nothing
  if pos < 0: return str

  parts = [ str[0:pos+1], str[pos+1:] ]

  parts[0] = ''.join(sorted(list(parts[0])))

  return ''.join(parts)

def solution(str, char):
  print(f'Input: $str = "{str}", $char = "{char}"')
  print(f'Output: "{reverseWord(str, char)}"')

print('Example 1:')
solution("challenge", "e")

print('\nExample 2:')
solution("programming", "a")

print('\nExample 3:')
solution("champion", "b")
