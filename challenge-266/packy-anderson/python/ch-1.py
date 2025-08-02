#!/usr/bin/env python

from collections import Counter

def occursOnce(line):
  # create a Counter of all words
  all = Counter(line.split())
  # create a list of words that occur once in the Counter
  return [ word for word in list(all) if all[word] == 1 ]

def uncommonWords(line1, line2):
  return occursOnce(
     ' '.join(occursOnce(line1) + occursOnce(line2))
  )

def quoted_comma_join(arr):
    return "'" + "', '".join(arr) + "'"

def solution(line1, line2):
    print(f"Input: $line1 = '{line1}'")
    print(f"       $line2 = '{line2}'")
    uncommon = uncommonWords(line1, line2)
    print(f'Output: ({quoted_comma_join(uncommon)})')

print('Example 1:')
solution('Mango is sweet', 'Mango is sour')

print('\nExample 2:')
solution('Mango Mango', 'Orange')

print('\nExample 3:')
solution('Mango is Mango', 'Orange is Orange')
