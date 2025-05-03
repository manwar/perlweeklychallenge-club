#!/usr/bin/env python

import re

vowels = '[aeiou]'

starts_or_ends_with_vowel = rf'\b{vowels}|{vowels}\b'

def wordCount(word_list):
  matched = []
  for word in word_list:
    if re.search(starts_or_ends_with_vowel, word):
      matched.append(word)
  return len(matched)

def solution(word_list):
    joined = '"' + '", "'.join(word_list) + '"'
    print(f'Input: @list = ({joined})')
    print(f'Output: {wordCount(word_list)}')

print('Example 1:')
solution(["unicode", "xml", "raku", "perl"])

print('\nExample 2:')
solution(["the", "weekly", "challenge"])

print('\nExample 3:')
solution(["perl", "python", "postgres"])
