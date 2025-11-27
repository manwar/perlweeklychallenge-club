#!/usr/bin/env python

def power_string(mystr):
  longest = 0
  chars   = [ c for c in mystr ]
  last    = chars.pop(0)
  count   = 1
  for current in chars:
    if current == last: # same as last char
      count += 1
    else: # character has changed
      if count > longest:
        longest = count
      count = 1
      last  = current
  if count > longest:
    longest = count # last sequence is longest
  return longest

def solution(mystr):
  print(f'Input: $str = "{mystr}"')
  print(f'Output: {power_string(mystr)}')

print('Example 1:')
solution("textbook")

print('\nExample 2:')
solution("aaaaa")

print('\nExample 3:')
solution("hoorayyy")

print('\nExample 4:')
solution("x")

print('\nExample 5:')
solution("aabcccddeeffffghijjk")
