#!/usr/bin/env python

def max_score2(mystr, split, count, maxval, explain):
  left  = mystr[0:split]
  right = mystr[split:]
  zeros = len([ c for c in list(left)  if c == "0" ])
  ones  = len([ c for c in list(right) if c == "1" ])
  mysum = zeros + ones
  explain += (
    f'\n{count}: left = "{left}", right = "{right}"' +
    f' => {zeros} + {ones} => {mysum}'
  )
  maxval = max(maxval, mysum)
  if len(right) == 1:
    # there's no more to split!
    return maxval, explain
  return max_score2(mystr, split+1, count+1, maxval, explain)

def max_score(mystr):
 return max_score2(mystr, 1, 1, 0, "")

def solution(mystr):
  print(f'Input: $str = "{mystr}"')
  maxval, explain = max_score(mystr)
  print(f'Output: {maxval}\n{explain}')

print('Example 1:')
solution("0011")

print('\nExample 2:')
solution("0000")

print('\nExample 3:')
solution("1111")

print('\nExample 4:')
solution("0101")

print('\nExample 5:')
solution("011101")
