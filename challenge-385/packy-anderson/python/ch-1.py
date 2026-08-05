#!/usr/bin/env python

from collections import Counter

def uncommon_words(sentence1, sentence2):
  return sorted([     # sort so the answer's always the same
    k for k,v in      # return just the keys
    Counter(          # count occurrences of each word
      (sentence1 + " " + sentence2) # make two sentences one
      .split()        # split on whitespace
    ).items() if v == 1 # filter for words that happen once
  ])

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(sentence1, sentence2):
  print(f'Input: $sentence1 = "{sentence1}"')
  print(f'       $sentence2 = "{sentence2}"')
  print(f'Output: ({quote_join(uncommon_words(sentence1, sentence2))})')

print('Example 1:')
solution("apple banana apple", "banana orange")

print('\nExample 2:')
solution("cat dog", "bird fish")

print('\nExample 3:')
solution("the quick brown fox", "the quick")

print('\nExample 4:')
solution("hello", "hello")

print('\nExample 5:')
solution("blue blue red", "red green green yellow")
