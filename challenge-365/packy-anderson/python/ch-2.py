#!/usr/bin/env python

import regex

valid_token = regex.compile(r'^(?:\p{Ll}+\-)?\p{Ll}+[!.,]?$')
                            
def valid_token_count(string):
  return len(
    [ w for w in string.split() if valid_token.match(w) ]
  )

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {valid_token_count(string)}')

print('Example 1:')
solution("cat and dog")

print('\nExample 2:')
solution("a-b c! d,e")

print('\nExample 3:')
solution("hello-world! this is fun")

print('\nExample 4:')
solution("ab- cd-ef gh- ij!")

print('\nExample 5:')
solution("wow! a-b-c nice.")
