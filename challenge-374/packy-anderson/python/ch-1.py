#!/usr/bin/env python

import re

all_vowels = re.compile(
  r'(?=.*a)(?=.*e)(?=.*i)(?=.*o).*u.*', flags=re.I
)

def check_substrings(string):
  if not all_vowels.search(string):
    return []
  output = []
  output.append(string)
  output.extend(check_substrings(string[1:]))
  output.extend(check_substrings(string[:-1]))
  return list(set(output)) # unique elements

def count_vowel(string):
  output = []
  for s in re.split(r'[^aeiou]+', string, flags=re.I):
    output.extend(check_substrings(s))
  return sorted(output)

def solution(string):
  print(f'Input: $str = "{string}"')
  output = [ f'"{s}"' for s in count_vowel(string) ]
  print(f'Output: ({", ".join(output)})')

print('Example 1:')
solution("aeiou")

print('\nExample 2:')
solution("aaeeeiioouu")

print('\nExample 3:')
solution("aeiouuaxaeiou")

print('\nExample 4:')
solution("uaeiou")

print('\nExample 5:')
solution("aeioaeioa")
