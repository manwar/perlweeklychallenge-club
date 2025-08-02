#!/usr/bin/env python

from collections import Counter

def distinctAverages(nums):
  nums.sort() # list.sort() works in place
  explain, step = "", 0
  averages = Counter()
  while nums:
    min, max = nums.pop(0), nums.pop(-1)
    avg = (min + max) / 2
    # since in Python, this will always produce a real number,
    # we need to do a little more work to make sure avg is an
    # integer when it has no fractional component
    if avg == int(avg):
      avg = int(avg)
    step += 1
    explain += (
      f"Step {step}: Min = {min}, Max = {max}, Avg = {avg}\n"
    )
    averages[avg] += 1
  count = len(list(averages))
  explain += (
    f"\nThe count of distinct average is {count}."
  )
  return count, explain

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(nums):
  print(f'Input: @nums = ({int_join(", ", nums)})')
  count, explain = distinctAverages(nums)
  print(f'Output: {count}\n\n{explain}')

print('Example 1:')
solution([1, 2, 4, 3, 5, 6])

print('\nExample 2:')
solution([0, 2, 4, 8, 3, 5])

print('\nExample 3:')
solution([7, 3, 1, 0, 5, 9])

print('\nExample 4:')
solution([1, 9, 2, 6, 3, 4])