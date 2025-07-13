#!/usr/bin/env python

from collections import Counter
import re

def swapCase(l):
  return l.upper() if l.lower() == l else l.lower()

def niceString(strVar):
  # convert the string to a Bag, er, Counter
  # so we know which characters are in it
  seen = Counter(list(strVar))

  # loop through the letters and make a list
  # of those that only appear in one case
  notBothCases = []
  for l in list(seen):
    if swapCase(l) not in list(seen):
      notBothCases.append(l)

  if notBothCases:
    # build a regex of the characters we're removing
    replace = re.compile('[' + ''.join(notBothCases) + ']+')

    # replace those characters with space
    strVar = replace.sub(' ', strVar)

  # get rid of leading and trailing whitespace
  strVar = strVar.strip()

  # split on whitespace
  substrings = strVar.split()

  # loop through the substrings we've found and find the longest
  longest = ''
  for s in substrings:
    if len(s) > len(longest):
      longest = s

  return longest

def solution(strVar):
  print(f'Input: $str = "{strVar}"')
  print(f'Output: "{niceString(strVar)}"')


print('Example 1:')
solution("YaaAho")

print('\nExample 2:')
solution("cC")

print('\nExample 3:')
solution("A")

print('\nExample 4:')
solution("AaBcDEFdefGhIiJjKlm")