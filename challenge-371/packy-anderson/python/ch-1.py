#!/usr/bin/env python

def missing(seq):
  diff = [None, None, None, None]
  # determine the differences we know
  for i in range(4):
    if seq[i] == '?' or seq[i+1] == '?': continue
    diff[i] = ord(seq[i+1]) - ord(seq[i])

  # fill in the missing differences
  for i in range(4):
    if diff[i] == None: diff[i] = diff[(i+2) % 4]

  # special case: the first letter is missing
  if seq[0] == '?':
    return chr(ord(seq[1]) - diff[0])

  # calculate the missing letter
  for i in range(1,5):
    if seq[i] == '?': return chr(ord(seq[i-1]) + diff[i-1])

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(seq):
  print(f'Input: @seq = qw({" ".join(seq)})')
  print(f'Output: {missing(seq)}')

print('Example 1:')
solution(["a", "c", "?", "g", "i"])

print('\nExample 2:')
solution(["a", "d", "?", "j" ,"m"])

print('\nExample 3:')
solution(["a", "e", "?", "m", "q"])

print('\nExample 4:')
solution(["a", "c", "f", "?", "k"])

print('\nExample 5:')
solution(["b", "e", "g", "?", "l"])

print('\nExample 6:')
solution(["?", "t", "v", "x", "z"])

print('\nExample 7:')
solution(["l", "m", "o", "p", "?"])
