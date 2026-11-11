#!/usr/bin/env python

import re

def substrings(string):
  # gather the substrings
  matches = re.findall(r"((?P<char>.)(?P=char)*)", string)

  # keep only the substrings (the first match),
  # not the single char char (the second match)
  return [ x[0] for x in matches ]

def shift_right(i, strings):
  # replace the first character of the ($i+1)th string
  # with the first character of the ($i)th string
  return shift_char(i, "r", strings)

def shift_left(i, strings):
  # replace the last character of the ($i)th string
  # with the first character of the ($i+1)th string
  return shift_char(i, "l", strings)

def shift_char(i, dir, strings):
  # replace the last character of the ($i)th string
  # with the first character of the ($i+1)th string
  newstr = ""
  s = i+1 if dir == "r" else i
  e = i+2 if dir == "r" else i+1
  for j in range(0, s): newstr += strings[j]
  if dir == "r":
    newstr += strings[i][0:1] + strings[i+1][1:]
  else:
    newstr += strings[i][1:] + strings[i+1][0:1]
  for j in range(e, len(strings)): newstr += strings[j]
  return newstr

def longest_repeating_character(string, k):
  # gather the substrings
  subs = substrings(string)

  # no more substitutions or only one substring
  if k == 0 or len(subs) == 1:
    return max([ len(s) for s in subs ])

  # make new substrings recursively
  longest = {}
  for i in range(0, len(subs)-1):
    newstr = shift_right(i, subs)
    longest[newstr] = longest_repeating_character(newstr, k-1)
    newstr = shift_left(i, subs)
    longest[newstr] = longest_repeating_character(newstr, k-1)
  return max(longest.values())

def solution(string, k):
  print(f'Input: $str = "{string}", $k = {k}')
  count = longest_repeating_character(string, k)
  print(f'Output: {count}')

print('Example 1')
solution("AAAAA", 2)

print('\nExample 2')
solution("ABCDE", 4)

print('\nExample 3')
solution("AAABBBBAA", 1)

print('\nExample 4')
solution("ABACADA", 2)

print('\nExample 5')
solution("BAAABAAAA", 1)
