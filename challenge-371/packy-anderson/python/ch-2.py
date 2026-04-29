#!/usr/bin/env python

from functools import reduce

def subsets(arr):
  return reduce(lambda r, i: r + [s + [i] for s in r], arr, [[]])

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def equilibrium(nums):
  tuples = [ (i, v) for i, v in enumerate(nums, start=1) ]
  results = []
  explain = []
  count = 0
  # loop over the subsets
  for s in subsets(tuples):
    # only consider PROPER subsets with 2 or more elements
    if len(s) < 2 or len(s) == len(tuples): continue
    indices = [ e[0] for e in s ]
    values  = [ e[1] for e in s ]
    if not sum(indices) == sum(values): continue
    count += 1
    plus_values  = int_join(' + ', values)
    plus_indices = int_join(' + ', indices)
    explanation = (
      f"Subset {count}: ({ int_join(', ', values) })\n" +
      f"Values: {plus_values} = { sum(values) }\n" +
      f"Positions: {plus_indices} = { sum(indices) }"
    )
    explain.append(explanation)
    results.append(values)
  return "\n\n".join(explain), results

def display_subsets(subsets):
  if not subsets:
    return '()' # special case
  return ', '.join([ '(' + int_join(', ', s) + ')' for s in subsets ])

def solution(nums):
  print(f'Input: @nums = ({int_join(", ", nums)})')
  explain, result = equilibrium(nums)
  print(f'Output: {display_subsets(result)}')
  if explain: print(f'\n{explain}')

print('Example 1:')
solution([2, 1, 4, 3])

print('\nExample 2:')
solution([3, 0, 3, 0])

print('\nExample 3:')
solution([5, 1, 1, 1])

print('\nExample 4:')
solution([3, -1, 4, 2])

print('\nExample 5:')
solution([10, 20, 30, 40])
