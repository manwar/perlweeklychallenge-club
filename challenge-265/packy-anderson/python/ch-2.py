#!/usr/bin/env python

from collections import Counter

def letterCounts(strVal):
  counts = Counter()
  for c in strVal.lower():
    if c.isalpha():
      counts[c] += 1
  return counts

def completingWord(targetStr, candidateStrs):
  targetCounts = letterCounts(targetStr)
  shortest = None
  for s in candidateStrs:
    candidateCounts = letterCounts(s)
    isCandidate = True
    for c, i in targetCounts.items():
      #    this letter does not exist
      if ( not c in candidateCounts
           or # occurs fewer times
           candidateCounts[c] < i): 
         isCandidate = False
    if (isCandidate and 
        (shortest is None or len(s) < len(shortest))):
      shortest = s
  return shortest if shortest is not None else ''

def comma_join(arr):
    return '\', \''.join(arr)

def solution(targetStr, candidateStrs):
    print(f'Input: $str = \'{targetStr}\'')
    print(f'       @str = (\'{comma_join(candidateStrs)}\')')
    output = completingWord(targetStr, candidateStrs)
    print(f'Output: \'{output}\'')

print('Example 1:')
solution('aBc 11c', ['accbbb', 'abc', 'abbc'])

print('\nExample 2:')
solution('Da2 abc', ['abcm', 'baacd', 'abaadc'])

print('\nExample 3:')
solution('JB 007', ['jj', 'bb', 'bjb'])