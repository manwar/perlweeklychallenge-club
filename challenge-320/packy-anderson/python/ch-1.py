#!/usr/bin/env python

def maxCount(ints):
  pos = 0
  neg = 0
  for int in ints:
    if int > 0:
      pos += 1
    elif int < 0:
      neg +=1
  max_count = max(pos, neg)
  explain = (
    f"There are {pos} positive integers.\n" +
    f"There are {neg} negative integers.\n" +
    f"The maximum between {pos} and {neg} is {max_count}."
  )
  return max_count, explain

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  max_count, explain = maxCount(ints)
  print(f'Output: {max_count}\n\n{explain}')

print('Example 1:')
solution([-3, -2, -1, 1, 2, 3])

print('\nExample 2:')
solution([-2, -1, 0, 0, 1])

print('\nExample 3:')
solution([1, 2, 3, 4])
