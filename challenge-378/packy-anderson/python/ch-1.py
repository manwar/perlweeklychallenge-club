#!/usr/bin/env python

def second_largest_digit(string):
  (one, two) = (-1, -1)
  digits = [ int(c) for c in string if c.isnumeric() ]
  for digit in digits:
    if digit > one:
      one, two = digit, one
    elif digit < one and digit > two:
      two = digit
  return two

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {second_largest_digit(string)}')

print('Example 1:')
solution("aaaaa77777")

print('\nExample 2:')
solution("abcde")

print('\nExample 3:')
solution("9zero8eight7seven9")

print('\nExample 4:')
solution("xyz9876543210")

print('\nExample 5:')
solution("4abc4def2ghi8jkl2")