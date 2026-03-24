#!/usr/bin/env python

def count_prefixes(string, array):
  return len([ s for s in array if string.find(s) == 0 ])

def solution(string, array):
  strlist = ", ".join([ f'"{s}"' for s in array])
  print(f'Input: @array = ({strlist}), $str = "{string}"')
  print(f'Output: {count_prefixes(string, array)}')

print('Example 1:')
solution("apple", ["a", "ap", "app", "apple", "banana"])

print('\nExample 2:')
solution("bird", ["cat", "dog", "fish"])

print('\nExample 3:')
solution("hello", ["hello", "he", "hell", "heaven", "he"])

print('\nExample 4:')
solution("coding", ["", "code", "coding", "cod"])

print('\nExample 5:')
solution("program", ["p", "pr", "pro", "prog", "progr", "progra", "program"])
