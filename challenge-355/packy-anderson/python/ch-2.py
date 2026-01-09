#!/usr/bin/env python

def mountain_array2(up, nums):
  first = nums.pop(0)

  # must be strictly greater than or strictly less than
  if first == nums[0]:
    return "false"

  # the penultimate element > last element
  if len(nums) == 1:
    if first > nums[0]:
      return "true"
    return "false"

  if not up: # we're going back down
    if first < nums[0]:
      return "false"
    return mountain_array2(0, nums)
  else: # we've been coming up
    if first > nums[0]:
      # first is the peak, head back down
      return mountain_array2(0, nums)
    # keep going up
    return mountain_array2(1, nums)

def mountain_array(nums):
  # arr.length >= 3
  if len(nums) < 3:
    return "false"

  # first element < second element
  first = nums.pop(0)
  if first > nums[0]:
    return "false"

  # check the rest of the array
  return mountain_array2(1, nums)

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(nums):
  print(f'Input: @ints = ({int_join(", ", nums)})')
  print(f'Output: {mountain_array(nums)}')

print('Example 1:')
solution([1, 2, 3, 4, 5])

print('\nExample 2:')
solution([0, 2, 4, 6, 4, 2, 0])

print('\nExample 3:')
solution([5, 4, 3, 2, 1])

print('\nExample 4:')
solution([1, 3, 5, 5, 4, 2])

print('\nExample 5:')
solution([1, 3, 2])

print('\nExample 6:')
solution([1, 5, 4, 3, 2, 1])