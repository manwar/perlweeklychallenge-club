#!/usr/bin/env python

from itertools import batched

def thousand_separator(num):
  # flow goes inside to top to bottom
  return(
    ",".join( # join the list on commas
      [
        # convert num into a string, reverse it, then batch it
        # every 3 characters, then join those 3 chars to a string
        # i.e., convert [[1, 2, 3], [4, 5]] to ["123", "45"]
        "".join(l) for l in batched(str(num)[::-1], 3)
      ]
    )[::-1] # reverse the string again
  )

def solution(num):
  print(f'Input: $int = {num}')
  print(f'Output: "{thousand_separator(num)}"')

print('Example 1:')
solution(123)

print('\nExample 2:')
solution(1234)

print('\nExample 3:')
solution(1000000)

print('\nExample 4:')
solution(1)

print('\nExample 5:')
solution(12345)
