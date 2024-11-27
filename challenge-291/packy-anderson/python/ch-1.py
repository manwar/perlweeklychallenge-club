#!/usr/bin/env python

def middleIndex(ints):
  for i in range(len(ints)):
    leftSum  = 0 if i == 0         else sum(ints[0:i])
    rightSum = 0 if i == len(ints) else sum(ints[i+1:])
    if leftSum == rightSum: return i
  return -1

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @inst = ({ comma_join(ints) })')
    print(f'Output: { middleIndex(ints) }')

print('Example 1:')
solution([2, 3, -1, 8, 4])

print('\nExample 2:')
solution([1, -1, 4])

print('\nExample 3:')
solution([2, 5])

print('\nExample 4:')
solution([0, 5])
