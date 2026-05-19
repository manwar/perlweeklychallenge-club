#!/usr/bin/env python

def equal_list(arr1, arr2):
  return ''.join(arr1) == ''.join(arr2)

def quote_list(arr):
  return ', '.join(map(lambda e: f'"{e}"', arr))

def solution(arr1, arr2):
  print(f'Input: @arr1 = ({quote_list(arr1)})')
  print(f'       @arr2 = ({quote_list(arr2)})')
  print(f'Output: {equal_list(arr1, arr2)}')

print('Example 1:')
solution(["a", "bc"], ["ab", "c"])

print('\nExample 2:')
solution(["a", "b", "c"], ["a", "bc"])

print('\nExample 3:')
solution(["a", "bc"], ["a", "c", "b"])

print('\nExample 4:')
solution(["ab", "c", ""], ["", "a", "bc"])

print('\nExample 5:')
solution(["p", "e", "r", "l"], ["perl"])
