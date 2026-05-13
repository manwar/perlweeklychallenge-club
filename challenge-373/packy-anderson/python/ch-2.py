#!/usr/bin/env python

def list_div(arr, n):
  if len(arr) < n: return -1
  c, r = divmod(len(arr), n)
  result = []
  while arr:
    a = []
    for i in range(0, c):
      a.append(arr.pop(0))
    if r: # we have a remainder to deal with
      a.append(arr.pop(0))
      r -= 1
    result.append(a)
  return result

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(arr, n):
  print(f'Input: @list = ({int_join(", ", arr)}), $n = {n}')
  results = list_div(arr,n)
  if results == -1:
    joined = str(results)
  else:
    joined = (
      "(" + ", ".join([
        "(" + int_join(",", a) + ")" for a in results
      ]) + ")"
    )
  print(f'Output: {joined}')

print('Example 1:')
solution([1,2,3,4,5], 2)

print('\nExample 2:')
solution([1,2,3,4,5,6], 3)

print('\nExample 3:')
solution([1,2,3], 2)

print('\nExample 4:')
solution([1,2,3,4,5,6,7,8,9,10], 5)

print('\nExample 5:')
solution([1,2,3], 4)

print('\nExample 6:')
solution([72,57,89,55,36,84,10,95,99,35], 7)
