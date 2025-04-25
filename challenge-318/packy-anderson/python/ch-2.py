#!/usr/bin/env python

def reverseEquals(source, target):
  # deal with the trivial cases
  if len(source) != len(target):
    # @source and @target are different lengths
    return (False, "")

  if source == target:
    # they're already the same
    return (True, "")

  # ok, now we start checking subarrays
  for i in range(len(source)-1):
    for j in range(i+1, len(source)):
      rev = []
      if i > 0:
        rev = source[0:i]
      rev.extend(list(reversed(source[i:j+1])))
      if j < len(source)-1:
        rev.extend(source[j+1:])
      if rev == target:
        return (True, f'{i}-{j}')

  return (False, "")

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(source, target):
    print(f'Input: @source = ({comma_join(source)})')
    print(f'       @target = ({comma_join(target)})')
    (equals, elements) = reverseEquals(source, target)
    print(f'Output: {equals}')
    if elements:
        print(f'\nReverse elements: {elements}')

print('Example 1:')
solution([3, 2, 1, 4], [1, 2, 3, 4])

print('\nExample 2:')
solution([1, 3, 4], [4, 1, 3])

print('\nExample 3:')
solution([2], [2])
