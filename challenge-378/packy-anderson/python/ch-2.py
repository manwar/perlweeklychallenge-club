#!/usr/bin/env python

def pquote(string, width):
  return f'"{string}"'.rjust(width)

def sum_of_words(str1, str2, str3):
  width = max(len(str1), len(str2), len(str3))
  table = str.maketrans("abcdefghij", "0123456789")
  num1 = str1.translate(table)
  num2 = str2.translate(table)
  num3 = str3.translate(table)
  return (
    "True" if int(num1) + int(num2) == int(num3) else "False",
    f'$str1 = {pquote(str1, width+2)} = ' +
    f'{num1.rjust(width)}\n' +
    f'$str2 = {pquote(str2, width+2)} = ' +
    f'{num2.rjust(width)}\n' +
    f'$str3 = {pquote(str3, width+2)} = ' +
    f'{num3.rjust(width)}'
  )

def solution(str1, str2, str3):
  print(f'Input: $str1 = "{str1}", $str2 = "{str2}", ' +
        f'$str3 = "{str3}"')
  result, explain = sum_of_words(str1, str2, str3)
  print(f'Output: {result}\n\n{explain}')

print('Example 1:')
solution("acb", "cba", "cdb")

print('\nExample 2:')
solution("aab", "aac", "ad")

print('\nExample 3:')
solution("bc", "je", "jg")

print('\nExample 4:')
solution("a", "aaaa", "aa")

print('\nExample 5:')
solution("c", "d", "h")

print('\nExample 6:')
solution("gfi", "hbf", "bdhd")
