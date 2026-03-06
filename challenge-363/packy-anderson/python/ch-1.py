#!/usr/bin/env python

import re
from word2number import w2n

extract_regex = re.compile(
  r'(?P<string> \w+ ) \s+ [\-\—\―]+ \s+'
  r'(?P<vowels> .+  ) \s+ vowels?'
  r'\s+ and \s+'
  r'(?P<consonants> .+ ) \s+ consonants?', re.X)

vowels     = re.compile(r'[aeiou]')
consonants = re.compile(r'[^aeiou]')

def comb(string, regex):
  return [ c for c in string if regex.match(c) ]

def lie_detector(string):
  r = extract_regex.search(string)
  vowel_count     = len(comb(r.group('string'), vowels))
  consonant_count = len(comb(r.group('string'), consonants))
  vowel_claim     = w2n.word_to_num(r.group('vowels'))
  consonant_claim = w2n.word_to_num(r.group('consonants'))
  return(vowel_count     == vowel_claim
     and consonant_count == consonant_claim)

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {lie_detector(string)}')

print('Example 1:')
solution("aa — two vowels and zero consonants")

print('\nExample 2:')
solution("iv — one vowel and one consonant")

print('\nExample 3:')
solution("hello - three vowels and two consonants")

print('\nExample 4:')
solution("aeiou — five vowels and zero consonants")

print('\nExample 5:')
solution("aei — three vowels and zero consonants")
