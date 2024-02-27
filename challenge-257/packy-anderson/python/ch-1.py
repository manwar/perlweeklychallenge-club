#!/usr/bin/env python

def smallerThan(ints):
  counts = []
  for i in range(len(ints)):
    counts.append(0)
    for j in range(len(ints)):
      if i != j and ints[j] < ints[i]: counts[i] += 1
  return counts

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    counts = smallerThan(ints)
    print(f'Output: ({comma_join(counts)})')

print('Example 1:')
solution([5, 2, 1, 6])

print('\nExample 2:')
solution([1, 2, 0, 3])

print('\nExample 3:')
solution([0, 1])

print('\nExample 4:')
solution([9, 4, 9, 2])