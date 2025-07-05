#!/usr/bin/env python

import regex

def hasBadMatch(str):
  # sanity check: only check if it's long enough
  if len(str) < 2: return False

  # match a sequence of two of the same character,
  # but be case-insensitive
  m = regex.search(r'(\p{L})\1', str, regex.I)

  # we didn't match, so return false
  if not m: return False

  # get the characters matched
  char1 = m.group(0)[0:1]
  char2 = m.group(0)[1:]

  if (char1 != char2 # it's not the same character, same case
      and 
      # they're the same character with different case!
      (char1 == char2.lower() or char1 == char2.upper())):
    return m

  # the match wasn't of differeing case, so search the
  # rest of the string AFTER the match
  hasBadMatch(str[m.end():])

def goodString(str):
  # see if the string has a sequence of the same character twice,
  # once upper case and once lower case, in any order
  m = hasBadMatch(str)

  # return the unmodified string if there are no matches
  if not m: return str

  # we don't need a regular expression, since we have the
  # character pair in m.group(0), we can use str.replace()
  #
  # recursively call the function with the new string
  return goodString(str.replace(m.group(0), '', count=1))

def solution(str):
  print(f'Input: $str = "{str}"')
  print(f'Output: "{goodString(str)}"')

print('Example 1:')
solution("WeEeekly")

print('\nExample 2:')
solution("abBAdD")

print('\nExample 3:')
solution("abc")
