#!/usr/bin/env python

def reverse_existence(string):
  gnirts = string[::-1]
  for i in range(len(string)-1):
    substr = string[i:i+2]
    if substr in gnirts: return "true"
  return "false"

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {reverse_existence(string)}')

print('Example 1:')
solution("abcba")

print('\nExample 2:')
solution("racecar")

print('\nExample 3:')
solution("abcd")

print('\nExample 4:')
solution("banana")

print('\nExample 5:')
solution("hello")
