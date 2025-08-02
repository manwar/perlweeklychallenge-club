#!/usr/bin/env python

import re

startsWithVowel = re.compile(r'^[aeiou]', re.I)

def goatLatin(sentence):
  words = sentence.split()
  new_words = []
  a_count = 1
  for word in words:
    if re.search(startsWithVowel, word):
      new_words.append(word + 'ma')
    else:
      first = word[0:1]
      rest  = word[1:]
      new_words.append(rest + first + 'ma')
    new_words[-1] += 'a' * a_count
    a_count += 1
  return ' '.join(new_words)

def solution(sentence):
    print(f'Input: $sentence = "{ sentence }"')
    print(f'Output: "{ goatLatin(sentence) }"')

print('Example 1:')
solution("I love Perl")

print('\nExample 2:')
solution("Perl and Raku are friends")

print('\nExample 3:')
solution("The Weekly Challenge")

print('\nExample 4:')
solution("Bus stop Bus goes She stays Love grows Under my umbrella")
