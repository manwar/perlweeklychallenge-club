#!/usr/bin/env python

def distinctAverages(nums):
  pass

def last_word(strVal):
  return len(strVal.split()[-1])

def solution(strVal):
  print(f'Input: $str = "{strVal}"')
  print(f'Output: {last_word(strVal)}')

print('Example 1:')
solution("The Weekly Challenge")

print('\nExample 2:')
solution("   Hello   World    ")

print('\nExample 3:')
solution("Let's begin the fun")
