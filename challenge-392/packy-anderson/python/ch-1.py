#!/usr/bin/env python

def is_palindrome(s):
  if len(s) <= 1: return True
  return s[0:1] == s[-1] and is_palindrome(s[1:-1])

def convert_palindrome(string):
  add = ""
  while not is_palindrome(string):
    add += string[-1]
    string = string[0:-1]
  return add + string + add[::-1]

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{convert_palindrome(string)}"')

print('Example 1:')
solution("pinnipeds")

print('\nExample 2:')
solution("abcd")

print('\nExample 3:')
solution("bananas")

print('\nExample 4:')
solution("dissident")

print('\nExample 5:')
solution("cailliachs")

print('\nExample 6:')
solution("gohangasalamiimalasagnahog")