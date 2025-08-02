#!/usr/bin/env python

def subsequence(str1, str2):
  # start at the beginning of both strings
  p1 = 0
  p2 = 0
  while (p2 < len(str2)):
    # if the current character of the first string matches
    # the current character of the second string...
    if (str1[p1] == str2[p2]):
      # move to the next character in the first string
      p1 += 1
    # if we've run off the end of the first string,
    # we wound up finding all the characters!
    if p1 == len(str1):
      return True

    # move to the next character of the second string
    p2 += 1

  # if we've run off the end of the second string,
  # this character isn't in the second string
  return False

def solution(str1, str2):
    print(f'Input: $str1 = "{str1}", $str2 = "{str2}"')
    print(f'Output: {subsequence(str1, str2)}')

print('Example 1:')
solution("uvw", "bcudvew")

print('\nExample 2:')
solution("aec", "abcde")

print('\nExample 3:')
solution("sip", "javascript")
