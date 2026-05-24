#!/usr/bin/env python

def might_as_well(i, jumps, ints):
  max_steps = ints[i]
  if i + max_steps >= len(ints)-1: return jumps
  if max_steps == 0: return -1 # dead end
  min_steps = []
  for j in range(max_steps, 0, -1):
    steps = might_as_well(i + j, jumps+1, ints)
    if steps == -1: continue  # dead end
    min_steps.append(steps)
  return min(min_steps) if min_steps else -1

def jump(ints):
  if len(ints) == 1: return 0  # we're already at the end
  return might_as_well(0, 1, ints)

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  print(f'Output: {jump(ints)}')

print('Example 1:')
solution([2, 3, 1, 1, 4])

print('\nExample 2:')
solution([2, 3, 0, 4])

print('\nExample 3:')
solution([2, 0, 0, 4])

print('\nExample 4:')
solution([3, 0, 0, 4])

print('\nExample 5:')
solution([1, 2, 3, 4, 5])

print('\nExample 6:')
solution([0])
