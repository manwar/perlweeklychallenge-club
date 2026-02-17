#!/usr/bin/env python

def word_sorter(string):
  return " ".join(sorted(string.split(), key=str.casefold))

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: "{word_sorter(string)}"')

print('Example 1:')
solution("The quick brown fox")

print('\nExample 2:')
solution("Hello    World!   How   are you?")

print('\nExample 3:')
solution("Hello")

print('\nExample 4:')
solution("Hello, World! How are you?")

print('\nExample 5:')
solution("I have 2 apples and 3 bananas!")
