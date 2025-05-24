#!/usr/bin/env python

def strFormat(strVar, i):
  strVar = strVar.replace("-", "")
  output = ''
  while (len(strVar) > i):
    output = "-" + strVar[-i:] + output
    strVar = strVar[0:-i] # Python strings are IMMUTABLE
  return strVar + output

def solution(strVar, i):
  print(f'Input: $str = "{strVar}", $i = {i}')
  output = strFormat(strVar, i)
  print(f'Output: "{output}"')


print('Example 1:')
solution("ABC-D-E-F", 3)

print('\nExample 2:')
solution("A-BC-D-E", 2)

print('\nExample 3:')
solution("-A-B-CD-E", 4)

print('\nExample 4:')
solution("-A-B-CD-E", 5)