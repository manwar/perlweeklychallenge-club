#!/usr/bin/env python

def max_same(string):
  digits  = list(string)
  current = digits.pop(0)
  largest = int(current)
  for digit in digits:
    current = (
      current + digit if current[0:1] == digit
                    else digit
    )
    largest = max(int(current), largest)
  return largest

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {max_same(string)}')

print('Example 1:')
solution("6777133339")

print('\nExample 2:')
solution("1200034")

print('\nExample 3:')
solution("44221155")

print('\nExample 4:')
solution("88888")

print('\nExample 5:')
solution("11122233")
