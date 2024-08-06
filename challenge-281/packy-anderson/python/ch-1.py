#!/usr/bin/env python

def isLight(coordinates):
  letter = coordinates[0:1]
  num = int(coordinates[1:])
  return (
     ( (letter in "aceg") and (num % 2 == 0) )
     or
     ( (letter in "bdfh") and (num % 2 == 1) )
  )

def solution(coordinates):
    print(f'Input: $coordinates = "{coordinates}"')
    print(f'Output: {isLight(coordinates)}')

print('Example 1:')
solution("d3")

print('\nExample 2:')
solution("g5")

print('\nExample 3:')
solution("e6")
