#!/usr/bin/env python

def my_reverse(string):
  gnirts = ""
  for char in string:
    gnirts = char + gnirts
  return gnirts

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{my_reverse(string)}"')

print('Example 1:')
solution("")

print('\nExample 2:')
solution("reverse the given string")

print('\nExample 3:')
solution("Perl is Awesome")

print('\nExample 4:')
solution("v1.0.0-Beta!")

print('\nExample 5:')
solution("racecar")
