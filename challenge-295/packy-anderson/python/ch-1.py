#!/usr/bin/env python

import re

def word_break(string, words):
  for word in words:
    string = re.sub(re.compile(word), " ", string)
  return 'true' if re.match(r'^\s*$', string) else 'false'

def solution(string, words):
  wordlist = ", ".join([ f'"{w}"' for w in words ])
  print(f'Input: $str = \'{string}\', @words = ({wordlist})')
  print(f'Output: {word_break(string, words)}')

print('Example 1:')
solution("weeklychallenge", ["challenge", "weekly"])

print('\nExample 2:')
solution("perlrakuperl", ["raku", "perl"])

print('\nExample 3:')
solution("sonsanddaughters", ["sons", "sand", "daughters"])

print('\nExample 4:')
solution("raperlrakuperlku", ["raku", "perl"])

print('\nExample 5:')
solution("thequickbrownfoxx", ["the", "quick", "brown", "fox"])
