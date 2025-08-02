#!/usr/bin/env python

from collections import Counter

def countCommon(words1, words2):
  # make Counters that count the words
  counts1 = Counter([ w.lower() for w in words1 ])
  counts2 = Counter([ w.lower() for w in words2 ])

  # filter to get set of words occuring only once
  counts1 = set([ w for w in counts1.keys() if counts1[w] == 1 ])
  counts2 = set([ w for w in counts2.keys() if counts2[w] == 1 ])

  # find the elements common in both
  common = counts1 & counts2
  return len(common)

def quoted_join(arr):
  return ', '.join(map(lambda i: f'"{i}"', arr))

def solution(words1, words2):
  print(f'Input: @words1 == ({quoted_join(words1)})')
  print(f'       @words2 == ({quoted_join(words2)})')
  print(f'Output: {countCommon(words1, words2)}')

print('Example 1:')
solution(["Perl", "is", "my", "friend"],
         ["Perl", "and", "Raku", "are", "friend"])

print('\nExample 2:')
solution(["Perl", "and", "Python", "are", "very", "similar"],
         ["Python", "is", "top", "in", "guest", "languages"])

print('\nExample 3:')
solution(["Perl", "is", "imperative", "Lisp", "is", "functional"],
         ["Crystal", "is", "similar", "to", "Ruby"])
