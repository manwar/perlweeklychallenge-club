#!/usr/bin/env python

def charPercent(strVal, charVal):
  char_cnt = len([ c for c in strVal if c == charVal ])
  return int( ( ( char_cnt / len(strVal) ) * 100 ) + 0.5 )

def solution(strVal, charVal):
    print(f'Input: $str = "{strVal}", $char = "{charVal}"')
    print(f'Output: { charPercent(strVal, charVal) }')

print('Example 1:')
solution("perl", "e")

print('\nExample 2:')
solution("java", "a")

print('\nExample 3:')
solution("python", "m")

print('\nExample 4:')
solution("ada", "a")

print('\nExample 5:')
solution("ballerina", "l")

print('\nExample 6:')
solution("analitik", "k")
