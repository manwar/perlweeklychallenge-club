#!/usr/bin/env python

def dyck_words(n):
  if n == 0: return [""]
  if n == 1: return ["UD"]
  new = []
  for i in range(1, int(n/2)+1):
    for word1 in dyck_words(n - i):
      for word2 in dyck_words(i):
        new.append(word2 + word1)
        new.append(word1 + word2)
        new.append(word2[0:i] + word1 + word2[i:])
  return sorted(set(new))

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

from textwrap import fill

def solution(n):
  print(f'Input: $n = {n}')
  words = quote_join(dyck_words(n))
  words = fill(words, width=70, subsequent_indent=(" "*9))
  print(f'Output: ({words})')

print('Example 1:')
solution(1)

print('\nExample 2:')
solution(2)

print('\nExample 3:')
solution(3)

print('\nExample 4:')
solution(0)

print('\nExample 5:')
solution(4)
