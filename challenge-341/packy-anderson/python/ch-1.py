#!/usr/bin/env python

import re

def broken_keys(mystr, keys):
  words = mystr.split()
  # if there are no broken keys,
  # we can type all the words
  if len(keys) == 0: return len(words)
  # build a character class
  regex = re.compile('[' + ''.join(keys) + ']', re.I)
  # count how many words don't match the class
  return( len([
    word for word in words if not re.search(regex, word)
  ]) )

def solution(mystr, keys):
  keylist = ",".join([ f"'{c}'" for c in keys ])
  print(f"Input: $str = '{mystr}', @keys = ({keylist})")
  print(f"Output: {broken_keys(mystr, keys)}")


print('Example 1:')
solution("Hello World", ["d"])

print('\nExample 2:')
solution("apple banana cherry", ["a", "e"])

print('\nExample 3:')
solution("Coding is fun", [])

print('\nExample 4:')
solution("The Weekly Challenge", ["a","b"])

print('\nExample 5:')
solution("Perl and Python", ["p"])
