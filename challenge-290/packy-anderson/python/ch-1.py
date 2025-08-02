#!/usr/bin/env python

def doubleExist(ints):
  for i in range(len(ints)):
    if ints[i] % 2 != 0:
      continue
    for j in range(len(ints)):
      if j == i:
        continue
      if ints[j] * 2 != ints[i]:
        continue
      explain = (
        f"For $i = {i}, $j = {j}\n" +
        f"$ints[$i] = {ints[i]} => 2 * {ints[j]} => " +
        "2 * $ints[$j]"
      )
      return 'true', explain
  return 'false', False

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  answer, explain = doubleExist(ints)
  print(f'Output: {answer}')
  if explain:
    print(f'\n{explain}')
        

print('Example 1:')
solution([6, 2, 3, 3])

print('\nExample 2:')
solution([3, 1, 4, 13])

print('\nExample 3:')
solution([2, 1, 4, 2])
