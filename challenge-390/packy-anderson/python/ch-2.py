#!/usr/bin/env python

def order_characters(string, k):
  seen  = [string]
  stack = [string]
  while stack:
    string = stack.pop(0)
    for i in range(0, k):
      char = string[i:i+1]
      new  = string[0:i] + string[i+1:] + char
      if new not in seen:
        seen.append(new)
        stack.append(new)
  return sorted(seen)[0]

def solution(string, k):
  print(f'Input: $str = "{string}", $k = {k}')
  print(f'Output: "{order_characters(string, k)}"')

print('Example 1:')
solution("dbca", 1)

print('\nExample 2:')
solution("geeks", 2)

print('\nExample 3:')
solution("cbaed", 3)

print('\nExample 4:')
solution("fedcba", 4)

print('\nExample 5:')
solution("perl", 1)

print('\nExample 6:')
solution("oloolooo", 1)

print('\nExample 7:')
solution("oloooolo", 1)
