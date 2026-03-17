#!/usr/bin/env python

def alpha_index_digit_sum(string, k):
  numstr = ''.join([ str(ord(c) - 96) for c in string ])
  while k > 0:
    numstr = str(sum([ int(n) for n in numstr]))
    k -= 1
  return numstr

def solution(string, k):
  print(f'Input: $str = "{string}", $k = {k}')
  print(f'Output: {alpha_index_digit_sum(string, k)}')

print('Example 1:')
solution("abc", 1)

print('\nExample 2:')
solution("az", 2)

print('\nExample 3:')
solution("cat", 1)

print('\nExample 4:')
solution("dog", 2)

print('\nExample 5:')
solution("perl", 3)

print('\nExample BigBird:')
solution("abcdefghijklmnopqrstuvwxyz", 1)
