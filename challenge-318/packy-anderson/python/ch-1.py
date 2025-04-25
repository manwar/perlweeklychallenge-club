#!/usr/bin/env python

import re

def groupPosition(str):
  # python doesn't support nested groups,
  # so let's match just the first occurence
  hasGroups = re.compile(r"([a-z])\1\1+", re.I)
  groups = []

  match = hasGroups.search(str)
  while match:
     # push the occurrence onto a list of groups
     # the 0th group is the entire match
     groups.append(match.group(0))
     # then remove from the start of the string to
     # the end of the first occurence
     str = str[match.end():]
     # and match against the new string
     match = hasGroups.search(str)

  if groups:
    return ', '.join([ f'"{s}"' for s in groups ])
  else:
    return '""'

def solution(str):
    print(f'Input: $str = "{str}"')
    print(f'Output: { groupPosition(str) }')

print('Example 1:')
solution("abccccd")

print('\nExample 2:')
solution("aaabcddddeefff")

print('\nExample 3:')
solution("abcdd")
