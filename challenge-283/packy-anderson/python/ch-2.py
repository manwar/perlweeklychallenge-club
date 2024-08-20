#!/usr/bin/env python

from collections import Counter

def digitCountValue(ints):
  bag = Counter(ints)  # count occurrences
  explain = []
  passes = True
  for digit in range(len(ints)):
    times  = ints[digit]
    occurs = bag[digit]
    otimes = (
      "0 times"         if occurs == 0 else
      f"{occurs} times" if occurs >= 2 else
      "1 time"
    )
    if times == occurs:
      explain.append(
        f"$ints[{digit}] = {times}, the digit {digit} " +
        f"occurs {otimes}"
      )
    else:
      passes = False
      ttimes = (
        "0 times"        if times == 0 else
        f"{times} times" if times >= 2 else
        "1 time"
      )
      explain.append(
        f"$ints[{digit}] = {times}, the digit {digit} " +
        f"occurs {otimes} rather than {ttimes}"
      )
  return passes, "\n".join(explain)

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  passes, explain = digitCountValue(ints)
  print(f'Output: {passes}\n\n{explain}')

print('Example 1:')
solution([1, 2, 1, 0])

print('\nExample 2:')
solution([0, 3, 0])

print('\nExample 3:')
solution([0, 1, 2, 2])
