#!/usr/bin/env python

def reverse_prefix(mystr, char):
  loc = mystr.find(char) + 1
  return mystr[0:loc][::-1] + mystr[loc:]

def solution(mystr, char):
  print(f'Input: $str = "{mystr}", $char = "{char}"')
  print(f'Output: "{reverse_prefix(mystr, char)}"')

print('Example 1:')
solution("programming", "g")

print('\nExample 2:')
solution("hello", "h")

print('\nExample 3:')
solution("abcdefghij", "h")

print('\nExample 4:')
solution("reverse", "s")

print('\nExample 5:')
solution("perl","r")
