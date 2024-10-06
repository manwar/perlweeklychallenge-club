#!/usr/bin/env python

from textwrap import fill
from random   import shuffle
from regex    import match

def rearrange(word):
  if len(word) < 3:
    return word

  chars = [ c for c in word ] # break word into characters
  letters = list(filter(lambda c: match(r"\p{L}", c), chars)) # only letters
  first = letters.pop(0);  # remove the first letter
  last  = letters.pop(-1); # remove the last letter
  shuffle(letters)         # shuffle the remaining letters
  letters.insert(0, first) # put the first letter back
  letters.append(last)     # put the last letter back

  # reassemble the word
  word = ''
  # loop over the char list
  for i in range(len(chars)):
    if match(r"\p{L}", chars[i]):
      # if it's a letter, pull it's replacement
      # off the @letters array
      word += letters.pop(0)
    else:
      # otherwise, it's punctuation, so
      # leave it alone
      word += chars[i]

  return word

def jumbleLetters(text):
  words = text.split()
  words[:] = [ rearrange(word) for word in words ]
  return " ".join(words)

def solution(text):
  print('Input:')
  print(fill(text, width=65))
  jumbled = jumbleLetters(text)
  print('\nOutput:')
  print(fill(jumbled, width=65))

print('Example 1:')
solution(
  "According to research at Cambridge University, it doesn't " +
  "matter in what order the letters in a word are, the only " +
  "important thing is that the first and last letter be at " +
  "the right place. The rest can be a total mess and you can " +
  "still read it without problem.  This is because the human " +
  "mind does not read every letter by itself, but the word as " +
  "a whole."
)

print('\nExample 2:')
solution("Perl Weekly Challenge")

print('\nExample 3:')
solution(
  "’Twas brillig, and the slithy toves " +
  "Did gyre and gimble in the wabe: " +
  "All mimsy were the borogoves, " +
  "And the mome raths outgrabe."
)

print('\nExample 4:')
solution(
  "My mother-in-law says I shouldn't've have used " +
  "so many parentheticals (but I completely disagree!)."
)
