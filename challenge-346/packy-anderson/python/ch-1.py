#!/usr/bin/env python

def longest_paren(my_str):
  found = []
  for start in range(len(my_str)-1):
    count = 0
    for end in range(start, len(my_str)):
      c = my_str[end:end+1]
      substring = my_str[start:end+1]
      if c == "(":
        count += 1
      else:
        count -= 1
      # unbalanced left paren
      if count < 0: break
      # we have exactly as many right parens as we've seen left
      if count == 0: found.append(substring)
    # if we've reached the end of $str and we're at 0,
    # any valid paren strings we find in subsequent outer loop
    # iterations will be substrings
    if count == 0: break
  found.sort(key=len)
  return len(found[-1])

def solution(my_str):
  print(f"Input: $str = '{my_str}'")
  print(f'Output: {longest_paren(my_str)}')

print('Example 1:')
solution("(()())")

print('\nExample 2:')
solution(")()())")

print('\nExample 3:')
solution("((()))()(((()")

print('\nExample 4:')
solution("))))((()(")

print('\nExample 5:')
solution("()(()")
