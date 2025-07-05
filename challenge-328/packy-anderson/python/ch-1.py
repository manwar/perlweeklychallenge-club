#!/usr/bin/env python

from   random import choice
import re
from   string import ascii_lowercase

hasQuestion = re.compile(
  r'(?P<before> . ) \?+ (?P<after> . )',
  re.X # ignore whitespace
)

def replaceAllQuestion(str):
  # return the unmodified string if there are no ? characters
  m = re.search(hasQuestion, str)
  if not m: return str

  # since we matched something, let's replace the first ? with a
  # character that won't produce a consecutive repeating character
  replace = choice([ # let's not always use the first character
    c for c in ascii_lowercase
      if c != m.group('before') and c != m.group('after')
  ])

  # we're EXPLICITLY only replacing the first ?
  str = re.sub(r'\?', replace, str, count=1)

  # recursively call this function to replace any remaining ?s
  return replaceAllQuestion(str)

def solution(str):
  print(f'Input: $str = "{str}"')
  print(f'Output: "{replaceAllQuestion(str)}"')

print('Example 1:')
solution("a?z")

print('\nExample 2:')
solution("pe?k")

print('\nExample 3:')
solution("gra?te")

print('\nExample 4:')
solution("so?c?r")

print('\nExample 5:')
solution("mi??i??i??i")

print('\nExample 6:')
solution("i??????????????????n")
