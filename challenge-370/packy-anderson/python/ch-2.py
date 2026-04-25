#!/usr/bin/env python

def divide(string, div):
  return (
    string[0:div],
    string[div:]
  )

def scramble(source, target):
  # If the string consists of only one character,
  # return the string
  if len(source) == 1: return source

  # if the string equals the target we're seeking,
  # return the string
  if source == target: return source

  s1, s2 = "", ""
  for div in range(1, len(source)):
    # Divide the string X into two non-empty parts
    s1, s2 = divide(source, div)
    t1, t2 = divide(target, div)

    # exchange the order of those parts unless one part
    # matches the target
    if not (s1 == t1 or s2 == t2):
      s2, s1 = s1, s2
      # adjust the target split as well
      t1, t2 = divide(target, len(s1))

    # scramble each of those parts unless all parts
    # match their targets
    if not (s1 == t1 and s2 == t2):
      s1, s2 = scramble(s1, t1), scramble(s2, t2)

    if s1 + s2 == target: break

  # Concatenate the scrambled parts to return a single string.
  return s1 + s2

def is_scrambled(source, target):
  return scramble(source, target) == target

def solution(str1, str2):
  print(f'Input: $str1 = "{str1}", $str2 = "{str2}"')
  print(f'Output: {is_scrambled(str1, str2)}')

print('Example 1:')
solution("abc", "acb")

print('\nExample 2:')
solution("abcd", "cdba")

print('\nExample 3:')
solution("hello", "hiiii")

print('\nExample 4:')
solution("ateer", "eater")

print('\nExample 5:')
solution("abcd", "bdac")
