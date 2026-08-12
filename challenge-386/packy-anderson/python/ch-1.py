#!/usr/bin/env python

# map chars => values like 'A': 10, 'a': 37
chars = {
  x: y for x, y in zip(
    [
      *"0123456789",
      *"ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      *"abcdefghijklmnopqrstuvwxyz",
      "+", "/"
    ],
    range(64)
  )
}

def reverse_base(num, base):
  return sum( # add it all up
    [ base ** k * v for k,v in # multiply by power
      zip(
        range(len(num)), # range of powers from 0 -> len(num)-1
        [ chars[c] for c # map character to numeric equivalent
          in list(num)   # break the number into digits
          [::-1] ]       # reverese the string so place -> power
      )
    ]
  )

def solution(num, base):
  print(f'Input: $num = "{num}", $base = {base}')
  print(f'Output: {reverse_base(num, base)}')

print('Example 1:')
solution("101010", 2)

print('\nExample 2:')
solution("EEADEE", 16)

print('\nExample 3:')
solution("755", 8)

print('\nExample 4:')
solution("1BRJB", 36)

print('\nExample 5:')
solution("7MyqL", 64)
