#!/usr/bin/env python

import regex

def strongPassword(str):
  hasUpper = 0
  hasLower = 0
  hasDigit = 0
  runs = []

  for char in str:
    # identify runs of characters
    if len(runs) == 0 or runs[-1][-1] != char:
      # we have no previous run of characters, or the last
      # character of the last run doesn't match this character
      runs.append(char)
    else:
      # append the latest character to the run
      runs[-1] += char

    # count the character classes we're interested in
    if   regex.match(r"\p{Lu}", char):
      hasUpper += 1
    elif regex.match(r"\p{Ll}", char):
      hasLower += 1
    elif regex.match(r"\p{N}", char):
      hasDigit += 1

  # count how many characters need to be REPLACED
  replacements = 0
  for run in runs:
    # if the run is 3 or more characters
    if len(run) >= 3:
      # we need one replacement per multiple of 3
      replacements += int(len(run) / 3)

  # figure out how many changes are needed
  changes = 0
  length  = len(str)

  for has in [hasUpper, hasLower, hasDigit]:
    if has == 0:
      changes += 1 # we need to add a character of this type

      # if we have characters that need to be REPLACED, we don't
      # need to add to the string length to make the change
      if replacements > 0:
        replacements -= 1
      else:
        # we need to add characters to make the change
        length += 1

  if length < 6:
    # not enough characters, we need MORE!
    changes += 6 - length

  if replacements > 0:
    # if we need more replacements, add them to the total
    changes += replacements

  return changes


def solution(str):
    print(f'Input: $str = "{str}"')
    print(f'Output: {strongPassword(str)}')

print('Example 1:')
solution("a")

print('\nExample 2:')
solution("aB2")

print('\nExample 3:')
solution("PaaSW0rd")

print('\nExample 4:')
solution("Paaasw0rd")

print('\nExample 5:')
solution("aaaaa")

print('\nExample 6:')
solution("aaaaaabbbb")

print('\nExample 7:')
solution("voilÀ३")
