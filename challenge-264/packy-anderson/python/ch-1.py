#!/usr/bin/env python

# make a translation table to switch the case of
# English letters
transTable = str.maketrans(
  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
)

def greatestEnglishLetter(strVar):
  seen = {}
  greatest = []

  # find the characters that exist as both
  # upper and lower case in the string
  for c in strVar:

    # note that we've seen the character
    seen[c] = 1

    # swap the case of the character
    C = c.translate(transTable)

    # if we've seen the swapped case version of the char,
    # add the uppercase version to our greatest hits
    if C in seen:
        greatest.append(c.upper())

  # if we found greatest characters,
  # return the greater of them
  if greatest:
    return max(greatest)

  # otherwise, return something that
  # represents an empty result
  return "''"

def solution(strVar):
    print(f"Input: '{strVar}'")
    print(f"Output: {greatestEnglishLetter(strVar)}")

print('Example 1:')
solution('PeRlwEeKLy')

print('\nExample 2:')
solution('ChaLlenge')

print('\nExample 3:')
solution('The')