#!/usr/bin/env python

def my_zip(longer, shorter, mystr):
  mystr += longer.pop(0) + shorter.pop(0)
  if len(shorter) > 0:
    return my_zip(longer, shorter, mystr)
  elif len(longer) > 0:
    return mystr + longer.pop(0)
  return mystr

def balance_str(mystr):
  letters = sorted([
    c for c in list(mystr) if not c.isnumeric()
  ])
  numbers = sorted([
    c for c in list(mystr) if     c.isnumeric()
  ])
  if abs(len(letters) - len(numbers)) > 1:
    return ""
  if len(letters) > len(numbers):
    return my_zip(letters, numbers, "")
  else:
    return my_zip(numbers, letters, "")

def solution(mystr):
  print(f'Input: $str = "{mystr}"')
  print(f'Output: "{balance_str(mystr)}"')

print('Example 1:')
solution("a0b1c2")

print('\nExample 2:')
solution("abc12")

print('\nExample 3:')
solution("0a2b1c3")

print('\nExample 4:')
solution("1a23")

print('\nExample 5:')
solution("ab123")
