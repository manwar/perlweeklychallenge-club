#!/usr/bin/env python

def is_trionic(arr):
  mode = 0
  for i in range(1, len(arr)):
    curr = arr[i]
    last = arr[i-1]
    if last == curr:
      return "false", -1, -1 # no strict increase
    if mode == 0 and last > curr:
      mode = 1 # proceed to strictly decreasing
      p = i - 1
    elif mode == 1 and last < curr:
      mode = 2 # proceed to strictly increasing
      q = i - 1
    elif mode == 2 and last >= curr:
      return "false", -1, -1 # no strict increase
  if not mode == 2:  return "false", -1, -1
  return "true", p, q

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr):
  print(f'Input: @arr = ({int_join(", ", arr)})')
  result, p, q = is_trionic(arr)
  print(f'Output: {result}')
  if result == "true":
    print(f'\nChoose p = {p} and q = {q}')

print('Example 1:')
solution([1, 3, 5, 4, 2, 6, 8])

print('\nExample 2:')
solution([1, 4, 4, 2, 1, 3, 5])

print('\nExample 3:')
solution([2, 10, 3, 1, 9])

print('\nExample 4:')
solution([1, 2, 3, 4, 3, 2, 1])

print('\nExample 5:')
solution([1, 3, 6, 4, 2, 7, 8, 4])
