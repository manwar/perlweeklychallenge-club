#!/usr/bin/env python

def prefix_suffix(array):
  count, explain = 0, ""
  for i in range(len(array)-1):
    istr = array[i]
    for j in range(i+1, len(array)):
      jstr = array[j]
      if not jstr.startswith(istr): continue
      if not jstr.endswith(istr): continue
      count += 1
      explain += f'\n$array[{i}], $array[{j}]: "{istr}" is '
      explain += f'a prefix and suffix of "{jstr}"'
  return count, explain

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(array):
  print(f'Input: @array = ({quote_join(array)})')
  count, explain = prefix_suffix(array)
  print(f'Output: {count}')
  if count:
    print(explain)

print('Example 1:')
solution(["a", "aba", "ababa", "aa"])

print('\nExample 2:')
solution(["pa", "papa", "ma", "mama"])

print('\nExample 3:')
solution(["abao", "ab"])

print('\nExample 4:')
solution(["abab", "abab"])

print('\nExample 5:')
solution(["ab", "abab", "ababab"])

print('\nExample 6:')
solution(["abc", "def", "ghij"])