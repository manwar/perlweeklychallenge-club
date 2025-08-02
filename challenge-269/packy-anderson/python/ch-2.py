#!/usr/bin/env python

def distributeElements(ints):
  # grab the first two elements off the given array
  # and put them in the two distribution arrays
  arr1 = [ ints.pop(0) ]
  arr2 = [ ints.pop(0) ]

  # loop through the remaining elements of the given array
  for i in ints:
    if arr1[-1] > arr2[-1]:
      arr1.append(i)
    else:
      arr2.append(i)

  # concatenate the arrays together
  return arr1 + arr2

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    out = distributeElements(ints)
    print(f'Output: ({comma_join(out)})')

print('Example 1:')
solution([2, 1, 3, 4, 5])

print('\nExample 2:')
solution([3, 2, 4])

print('\nExample 3:')
solution([5, 4, 3 ,8])