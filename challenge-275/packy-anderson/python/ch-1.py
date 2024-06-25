#!/usr/bin/env python

import re

def brokenKeys(sentence, keys):
  words = sentence.split()
  regex = re.compile('[' + ''.join(keys) + ']', re.I)
  return( len([
    word for word in words if not re.search(regex, word)
  ]) )

def solution(sentence, keys):
  keysStr = "'" + "', '".join(keys) + "'"
  print(f'Input: $sentence = "{sentence}", @keys = ({keysStr})')
  print(f'Output: {brokenKeys(sentence, keys)}')

print('Example 1:')
solution("Perl Weekly Challenge", ['l', 'a'])

print('\nExample 2:')
solution("Perl and Raku", ['a'])

print('\nExample 3:')
solution("Well done Team PWC", ['l', 'o'])

print('\nExample 4:')
solution("The joys of polyglottism", ['T'])
