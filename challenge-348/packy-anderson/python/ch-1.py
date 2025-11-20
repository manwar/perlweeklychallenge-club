#!/usr/bin/env python

import re

def countVowels(text):
  text = re.sub(r'[^aeiou]', '', text, flags=re.IGNORECASE)
  count = len(text)
  vowel = "vowel" if count == 1 else "vowels"
  return count, vowel

def string_alike(text):
  # split the string
  half_len = int(len(text) / 2)
  first    = text[0:half_len]
  second   = text[half_len:]
  # count the vowels
  count1, vowel1 = countVowels(first)
  explain = f'1st half: "{first}" ({count1} {vowel1})\n'
  count2, vowel2 = countVowels(second)
  explain += f'2nd half: "{second}" ({count2} {vowel2})'
  # return the result
  bool = "True" if count1 == count2 and count1 > 0 else "False"
  return f'{bool}\n\n{explain}'

def solution(text):
  print(f'Input: $str = "{text}"')
  print(f'Output: {string_alike(text)}')

print('Example 1:')
solution("textbook")

print('\nExample 2:')
solution("book")

print('\nExample 3:')
solution("AbCdEfGh")

print('\nExample 4:')
solution("rhythmmyth")

print('\nExample 5:')
solution("UmpireeAudio")
