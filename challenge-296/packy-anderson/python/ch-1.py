#!/usr/bin/env python

def rlEncode(charstr):
  chars = [ c for c in charstr ]
  last = chars.pop(0)
  count = 1
  result = ''
  for c in chars:
    if c == last: # same as last char,
      count += 1  # increment the count
    else:
      if count > 1:          # if the count > 1, include the
        result += str(count) # count in the encoded output
      result += last # add the last character to the output
      last = c  # make current char the last
      count = 1 # and reset the count

  # encode the last run of characters in the string
  if count > 1:
    result += str(count)
  result += last

  return result

def rlDecode(charstr):
  result = ''
  count  = ''
  for c in charstr:
    if c.isnumeric():
      count += c
    else:
      if count: # if there's a count
        result += c * int(count) # output that many of this char
        count = '' # reset the count
      else: # append character to output
        result += c

  return result

def solution(charstr):
  print(f'Input: $chars = "{charstr}"')
  encoded = rlEncode(charstr)
  print(f'Encoded: "{encoded}"')
  decoded = rlDecode(encoded)
  print(f'Decoded: "{decoded}"')

print('Example 1:')
solution("abbc")

print('\nExample 2:')
solution("aaabccc")

print('\nExample 3:')
solution("abcc")

print('\nExample 4:')
solution("abbbbbbbbbbbbccccccdd")
