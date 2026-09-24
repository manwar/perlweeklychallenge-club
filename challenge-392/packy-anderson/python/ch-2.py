#!/usr/bin/env python

from collections import Counter

def common(first, second):
  bag1 = Counter([ c for c in first])
  bag2 = Counter([ c for c in second])
  for c in bag1.keys():
    if c in bag2:
      return True
  return False

def wlp(words):
  words.sort(key=lambda k: (len(k), k), reverse=True)
  end = len(words)-1
  for i in range(end):
    for j in range(i+1, end+1): 
      if not common(words[i], words[j]):
        return len(words[i]) * len(words[j])
  return 0

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(words):
  print(f'Input: @words = ({quote_join(words)})')
  print(f'Output: {wlp(words)}')

print('Example 1:')
solution(["a", "ab", "abc", "d", "de", "def"])

print('\nExample 2:')
solution(["a", "aa", "aaa", "aaaa"])

print('\nExample 3:')
solution(["meet", "app", "code", "sky", "bold"])

print('\nExample 4:')
solution(["a", "ab", "abc", "abcd", "efghi"])

print('\nExample 5:')
solution(["xyz", "w", "abcdefg", "hij"])
