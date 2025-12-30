#!/usr/bin/env python

def min_abs_diff(ints):
  # sort so minimum difference items are next to each other
  ints.sort()
  # start with the largest possible difference
  min_val = abs(ints[-1] - ints[0])

  pairs = []
  last = ints.pop(0)

  for current in ints:
    diff = abs(current - last)
    pair = f"[{last}, {current}]"
    if diff == min_val: # same diff, add to list
      pairs.append(pair)
    elif diff < min_val: # start new list with this pair
      pairs = [pair]
      min_val = diff
    last = current

  return ", ".join(pairs)

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {min_abs_diff(ints)}')

print('Example 1:')
solution([4, 2, 1, 3])

print('\nExample 2:')
solution([10, 100, 20, 30])

print('\nExample 3:')
solution([-5, -2, 0, 3])

print('\nExample 4:')
solution([8, 1, 15, 3])

print('\nExample 5:')
solution([12, 5, 9, 1, 15])
