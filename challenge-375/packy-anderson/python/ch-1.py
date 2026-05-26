#!/usr/bin/env python

from collections import Counter

def single_set(array):
  return set([ k for k,v in Counter(array).items() if v == 1 ])

def single_common_count(array1, array2):
  return len(single_set(array1) & single_set(array2))

def quote_join(array):
  return ", ".join([ f'"{e}"' for e in array ])

def solution(array1, array2):
  print(f'Input: @array1 = ({quote_join(array1)})')
  print(f'       @array2 = ({quote_join(array2)})')
  print(f'Output: {single_common_count(array1, array2)}')

print('Example 1:')
solution(["apple", "banana", "cherry"],
         ["banana", "cherry", "date"])

print('\nExample 2:')
solution(["a", "ab", "abc"],
         ["a", "a", "ab", "abc"])

print('\nExample 3:')
solution(["orange", "lemon"],
         ["grape", "melon"])

print('\nExample 4:')
solution(["test", "test", "demo"],
         ["test", "demo", "demo"])

print('\nExample 5:')
solution(["Hello", "world"],
         ["hello", "world"])
