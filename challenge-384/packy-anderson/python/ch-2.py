#!/usr/bin/env python

import re

def special_binary_substrings(binary):
  arr = [ int(d) for d in binary ]
  # special case: all 0s or all 1s
  alen = len(arr)
  asum = sum(arr)
  if asum == 0 or asum == alen: return []

  seen = {} # keep track of substrings already checked
  # generate substrings and check
  for i in range(alen):
    for j in range(i+1, alen+1):
      subarr = arr[i:j]
      substr = ''.join([str(c) for c in subarr])
      if substr in seen: continue
      if (sum(subarr) == len(subarr)/2): # equal num 0 & 1
        if (re.match(r'^1+$', re.sub(r'^0+','',substr)) or
            re.match(r'^1+$', re.sub(r'0+$','',substr))):
          # consecutive
          seen[substr] = True
          continue
      seen[substr] = False
  return sorted([ k for k in seen.keys() if seen[k] ])

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(binary):
  print(f'Input: $binary = "{binary}"')
  output = quote_join(special_binary_substrings(binary))
  print(f'Output: ({output})')

print('Example 1:')
solution("0101")

print('\nExample 2:')
solution("000111")

print('\nExample 3:')
solution("000011")

print('\nExample 4:')
solution("10011100")

print('\nExample 5:')
solution("00000")
